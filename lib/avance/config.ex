defmodule Avance.Config do
  @moduledoc """
  This module contains the configuration for the application.
  """

  def slack_webhook, do: System.get_env("SLACK_WEBHOOK")
end
