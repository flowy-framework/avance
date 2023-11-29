defmodule Avance.Core.Notifiers.Notifier do
  @callback notify(reminder :: Avance.Schemas.Reminder.t()) :: :ok

  alias Avance.Core.Notifiers.{SlackNotifier, TestNotifier}
  alias Avance.Schemas.Reminder

  def notify(%Reminder{reminder_type: :slack} = reminder) do
    reminder
    |> SlackNotifier.notify()
  end

  def notify(%Reminder{reminder_type: :test} = reminder) do
    reminder
    |> TestNotifier.notify()
  end
end
