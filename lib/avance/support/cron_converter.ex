defmodule Avance.Support.CronConverter do
  @moduledoc """
  This module provides a simple interface for converting cron expressions to
  NaiveDateTime structs.
  """

  @doc """
  Returns the next run date for the given cron expression.
  """
  @spec next_run(String.t(), NaiveDateTime.t()) :: {:error, String.t()} | {:ok, NaiveDateTime.t()}
  def next_run(cron_expression, date \\ NaiveDateTime.utc_now())

  @spec next_run(any(), NaiveDateTime.t()) :: {:error, String.t()} | {:ok, NaiveDateTime.t()}
  def next_run(cron_expression, date) when is_binary(cron_expression) do
    with {:ok, expression} <- Crontab.CronExpression.Parser.parse(cron_expression) do
      next_run(expression, date)
    end
  end

  @spec next_run(Crontab.CronExpression.t(), NaiveDateTime.t()) ::
          {:error, String.t()} | {:ok, NaiveDateTime.t()}
  def next_run(%Crontab.CronExpression{} = cron_expression, date) do
    Crontab.Scheduler.get_next_run_date(cron_expression, date)
  end

  # Im not sure why I have to to this, but it seems that the
  # there is a bug https://github.com/maennchen/crontab/issues/119
  @spec next_run!(String.t(), NaiveDateTime.t()) :: NaiveDateTime.t()
  def next_run!(cron_expression, date) do
    after_next_run(cron_expression, date)
  end

  @doc """
  Returns the next run date for the given cron expression.
  """
  @spec after_next_run(String.t(), NaiveDateTime.t()) :: NaiveDateTime.t()
  def after_next_run(cron_expression, date \\ NaiveDateTime.utc_now()) do
    with {:ok, expression} <- Crontab.CronExpression.Parser.parse(cron_expression) do
      Enum.take(Crontab.Scheduler.get_next_run_dates(expression, date), 2)
      |> Enum.at(1)
    end
  end

  @doc """
  Returns the next run date for the given cron expression.
  """
  @spec next_run_in_seconds(String.t(), NaiveDateTime.t()) ::
          {:error, String.t()} | {:ok, integer()}
  def next_run_in_seconds(cron_expression, date \\ NaiveDateTime.utc_now()) do
    {:ok, next_run} = next_run(cron_expression, date)

    NaiveDateTime.diff(next_run, date)
  end

  @doc """
  Validates the given cron expression.
  """
  @spec valid?(String.t()) :: boolean()
  def valid?(cron_expression) do
    case Crontab.CronExpression.Parser.parse(cron_expression) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
end
