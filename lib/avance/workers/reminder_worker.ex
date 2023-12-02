defmodule Avance.Workers.ReminderWorker do
  use Oban.Worker,
    queue: :reminders,
    # We don't want this to be retried in case of a failure
    max_attempts: 1,

    # We want to make sure the same reminder is not scheduled twice
    unique: [
      # fields: [:worker, :queue, :args],
      period: 50,
      # period: :infinity,
      states: [:scheduled]
    ]

  alias Avance.Core.Reminders

  @impl true
  def perform(%{args: %{"id" => reminder_id}, scheduled_at: scheduled_at}) do
    %{enabled: enabled} =
      reminder = Reminders.get!(reminder_id)

    case enabled do
      true ->
        # TODO: Handle errors from notifiers
        reminder
        |> Reminders.notify()
        |> Reminders.update_last_run_at!(scheduled_at)
        |> Reminders.schedule()

      false ->
        reminder
    end

    :ok
  end
end
