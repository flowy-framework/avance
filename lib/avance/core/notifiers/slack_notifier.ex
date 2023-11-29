defmodule Avance.Core.Notifiers.SlackNotifier do
  @behaviour Avance.Core.Notifiers.Notifier

  alias Avance.Schemas.{Reminder, Notifiers.Slack}

  @impl true
  def notify(%Reminder{settings: settings, description: description}) do
    slack_settings = Slack.build(settings)
    Avance.Support.SlackClient.post_message(slack_settings.channel, description)
  end
end
