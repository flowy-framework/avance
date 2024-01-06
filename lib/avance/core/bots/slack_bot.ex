defmodule Avance.Core.Bots.SlackBot do
  @moduledoc """
  A simple Slack bot that responds to messages.
  """
  use Slack.Bot

  require Logger

  @impl true
  # A silly example of old-school style bot commands.
  @spec handle_event(any(), any()) :: nil | :ok
  def handle_event("message", %{"text" => "!" <> cmd, "channel" => channel, "user" => user}) do
    case cmd do
      "roll" ->
        send_message(channel, "<@#{user}> rolled a #{Enum.random(1..6)}")

      "echo " <> text ->
        send_message(channel, text)

      _ ->
        send_message(channel, "Unknown command: #{cmd}")
    end
  end

  def handle_event("message", %{"channel" => channel, "text" => text, "user" => user}) do
    if String.match?(text, ~r/hello/i) do
      send_message(channel, "Hello! <@#{user}>")
    end
  end

  def handle_event("app_mention", %{"channel" => channel, "text" => text, "user" => user}) do
    if String.match?(text, ~r/hello/i) do
      send_message(channel, "Hello! <@#{user}>")
    end
  end

  def handle_event(type, payload) do
    Logger.debug("Unhandled #{type} event: #{inspect(payload)}")
    :ok
  end
end
