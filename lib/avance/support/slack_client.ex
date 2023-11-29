defmodule Avance.Support.SlackClient do
  alias Flowy.Support.Http
  alias Avance.Config

  @username "avance"
  @icon_url "https://github.com/flowy-framework/avance/blob/b1b3bff9abfa0d63af8fa458f5b23d8a5a4c9686/logos/logo-bot.png?raw=true"

  @doc """
  Posts a message to a Slack channel.
  """
  @spec post_message(String.t(), any(), any()) :: {:ok, Flowy.Support.Http.Response.t()}
  def post_message(channel, message, opts \\ []) do
    webhook = Keyword.get(opts, :webhook, Config.slack_webhook())

    Http.post(
      webhook,
      %{channel: channel, text: message, username: @username, icon_url: @icon_url, mrkdwn: true},
      []
    )
  end
end
