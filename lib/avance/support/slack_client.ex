defmodule Avance.Support.SlackClient do
  @moduledoc """
  This module provides a simple interface for posting messages to Slack.
  """

  alias Flowy.Support.Http
  alias Avance.Config

  @username "avance"
  @icon_url "https://raw.githubusercontent.com/flowy-framework/avance/main/logos/logo-bot.png"

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
