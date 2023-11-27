defmodule Avance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
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

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Avance.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AvanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
