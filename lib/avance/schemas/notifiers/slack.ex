defmodule Avance.Schemas.Notifiers.Slack do
  @moduledoc """
  This schema represents a Slack notifier.
  """

  defstruct [:channel]

  @type t :: %__MODULE__{
          channel: String.t()
        }

  @doc """
  Build Slack settings from a map.
  """
  @spec build(map()) :: t()
  def build(%{"channel" => channel}) do
    build(%{channel: channel})
  end

  @spec build(map()) :: t()
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
