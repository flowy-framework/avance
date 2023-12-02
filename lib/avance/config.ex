defmodule Avance.Config do
  @moduledoc """
  This module contains the configuration for the application.
  """

  @doc """
  Returns the Slack webhook URL.
  """
  @spec slack_webhook() :: nil | String.t()
  def slack_webhook, do: System.get_env("SLACK_WEBHOOK")
end
