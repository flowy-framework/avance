defmodule Avance.Core.Notifiers.Notifier do
  @moduledoc """
  This module contains the business logic for notifiers.
  """

  @doc """
  Callback definition for the notifier.
  """
  @callback notify(reminder :: Avance.Schemas.Reminder.t()) :: :ok

  alias Avance.Core.Notifiers.{SlackNotifier, TestNotifier}
  alias Avance.Schemas.Reminder

  @doc """
  Send notification base on the reminder type
  """
  @spec notify(Reminder.t()) :: {:ok, any()}
  def notify(%Reminder{reminder_type: :slack} = reminder) do
    reminder
    |> SlackNotifier.notify()
  end

  @spec notify(Reminder.t()) :: {:ok, any()}
  def notify(%Reminder{reminder_type: :test} = reminder) do
    reminder
    |> TestNotifier.notify()
  end
end
