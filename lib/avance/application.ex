defmodule Avance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @env Mix.env()

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Avance.Supervisor]
    Supervisor.start_link(children(@env), opts)
  end

  defp children(:test) do
    [
      Flowy.Prometheus,
      AvanceWeb.Telemetry,
      Avance.Repo,
      {DNSCluster, query: Application.get_env(:avance, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Avance.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Avance.Finch},
      {Oban, Application.fetch_env!(:avance, Oban)},
      # Start a worker by calling: Avance.Worker.start_link(arg)
      # {Avance.Worker, arg},
      # Start to serve requests, typically the last entry
      AvanceWeb.Endpoint
    ]
  end

  defp children(_) do
    [
      Flowy.Prometheus,
      AvanceWeb.Telemetry,
      Avance.Repo,
      {DNSCluster, query: Application.get_env(:avance, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Avance.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Avance.Finch},
      {Oban, Application.fetch_env!(:avance, Oban)},
      # Start a worker by calling: Avance.Worker.start_link(arg)
      # {Avance.Worker, arg},
      # Start to serve requests, typically the last entry
      AvanceWeb.Endpoint,
      {Avance.Core.Servers.ReminderServer, []},
      {Slack.Supervisor, Application.get_env(:avance, Avance.Core.Bots.SlackBot)}
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AvanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
