defmodule Avance.Support.CronConverterTest do
  use ExUnit.Case
  alias Avance.Support.CronConverter

  test "next_run returns the correct next run date" do
    # This cron expression runs every minute
    {:ok, next_run_date} = CronConverter.next_run("* * * * *")

    assert NaiveDateTime.diff(next_run_date, NaiveDateTime.utc_now(), :second) <=
             60
  end

  test "next_run returns an error for an invalid cron expression" do
    assert {:error, _} = CronConverter.next_run("invalid_cron_expression")
  end

  test "valid? returns true for a valid cron expression" do
    assert CronConverter.valid?("* * * * *") == true
  end

  test "valid? returns false for an invalid cron expression" do
    assert CronConverter.valid?("invalid_cron_expression") == false
  end

  @tag :next_run_in_seconds
  test "next_run_in_seconds" do
    date = ~N[2024-04-17 14:00:01]
    assert CronConverter.next_run_in_seconds("@minutely", date) == 59
  end

  @tag :after_next_run
  test "after_next_run" do
    date = ~N[2024-04-17 14:00:01]
    assert CronConverter.after_next_run("@minutely", date) == ~N[2024-04-17 14:02:00]
  end

  @tag :cron_converter_next_run
  test "next_run!" do
    date = ~N[2024-04-17 14:00:01]
    assert CronConverter.next_run!("* * * * *", date) == ~N[2024-04-17 14:02:00]
  end
end
