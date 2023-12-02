defmodule Avance.Core.Reminders do
  @moduledoc """
  This module contains the business logic for reminders.
  """
  use Timex
  alias Avance.Support.CronConverter
  alias Avance.Schemas.Reminder
  alias Avance.Queries.ReminderQuery
  alias Avance.Core.Notifiers.Notifier
  alias Avance.Workers.ReminderWorker

  defdelegate all, to: ReminderQuery
  defdelegate get(id), to: ReminderQuery
  defdelegate last(limit), to: ReminderQuery
  defdelegate get!(id), to: ReminderQuery
  defdelegate update!(mode, attrs), to: ReminderQuery
  defdelegate update(mode, attrs), to: ReminderQuery
  defdelegate delete(mode), to: ReminderQuery
  defdelegate delete_all(), to: ReminderQuery
  defdelegate create(attrs), to: ReminderQuery
  defdelegate change(model, attrs \\ %{}), to: ReminderQuery, as: :changeset

  @doc """
  Schedule all existing active reminders
  """
  @spec schedule() :: list()
  def schedule() do
    ReminderQuery.search(%{enabled: true})
    |> Enum.map(&schedule(&1))
  end

  @spec schedule(Avance.Schemas.Reminder.t()) ::
          {:error, :reminder_disabled} | Avance.Schemas.Reminder.t()
  def schedule(%Reminder{enabled: true} = reminder) do
    next_run =
      reminder
      |> next_run()

    %{id: reminder.id}
    |> ReminderWorker.new(scheduled_at: next_run)
    |> Oban.insert!()

    reminder
  end

  @doc """
  Schedule a reminder
  """
  def schedule(%Reminder{enabled: false}) do
    {:error, :reminder_disabled}
  end

  @doc """
  Update last run at for a reminder
  """
  def update_last_run_at!(%Reminder{} = reminder, last_run_at \\ DateTime.utc_now()) do
    update!(reminder, %{last_run_at: last_run_at})
  end

  @doc """
  Send notification
  """
  @spec notify(Reminder.t()) :: none()
  def notify(%Reminder{enabled: true} = reminder) do
    reminder
    |> Notifier.notify()

    reminder
  end

  def notify(%Reminder{enabled: false}) do
    {:error, :reminder_disabled}
  end

  @doc """
  Calculate the next run for a reminder
  """
  def run_at(%Reminder{last_run_at: last_run_at, timezone: timezone}, :datetime) do
    last_run_at = last_run_at || Timex.now()
    timezone = Timezone.get(timezone, last_run_at)
    Timezone.convert(last_run_at, timezone)
  end

  def run_at(%Reminder{} = reminder, :naive) do
    reminder
    |> run_at(:datetime)
    |> Timex.to_naive_datetime()
  end

  @doc """
  Calculate the next run for a reminder
  """
  def next_run(reminder) do
    naive_last_run_at = run_at(reminder, :naive)

    next_run =
      reminder.schedule
      |> CronConverter.next_run!(naive_last_run_at)
      |> Timex.to_datetime()
      |> DateTime.shift_zone!("Etc/UTC")

    case NaiveDateTime.before?(next_run, NaiveDateTime.utc_now()) do
      true ->
        DateTime.utc_now()

      false ->
        next_run
    end
  end
end
