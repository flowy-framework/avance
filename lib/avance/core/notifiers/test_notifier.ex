defmodule Avance.Core.Notifiers.TestNotifier do
  @moduledoc """
  This module contains the business logic for the Test notifier.
  """
  @behaviour Avance.Core.Notifiers.Notifier

  alias Avance.Schemas.Reminder

  @doc """
  Send notification to Slack
  """
  @spec notify(Reminder.t()) :: {:ok, String.t()}
  @impl true
  def notify(%Reminder{description: description}) do
    {:ok, description}
  end
end
