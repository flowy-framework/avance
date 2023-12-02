defmodule Avance.Core.Notifiers.SlackNotifier do
  @moduledoc """
  This module contains the business logic for the Slack notifier.
  """
  @behaviour Avance.Core.Notifiers.Notifier

  alias Avance.Schemas.{Reminder, Notifiers.Slack}

  @doc """
  Send notification to Slack
  """
  @spec notify(Reminder.t()) :: none()
  @impl true
  def notify(%Reminder{settings: settings, description: description}) do
    slack_settings = Slack.build(settings)
    Avance.Support.SlackClient.post_message(slack_settings.channel, description)
  end
end
