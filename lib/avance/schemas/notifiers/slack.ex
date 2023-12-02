defmodule Avance.Schemas.Notifiers.Slack do
  defstruct [:channel]

  def build(%{"channel" => channel}) do
    build(%{channel: channel})
  end

  def build(%{channel: channel}) do
    struct(__MODULE__, %{channel: channel_name(channel)})
  end

  defp channel_name(channel) do
    if String.starts_with?(channel, "#") do
      channel
    else
      "##{channel}"
    end
  end
end
