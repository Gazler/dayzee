defmodule Dayzee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DayzeeWeb.Telemetry,
      Dayzee.Repo,
      {DNSCluster, query: Application.get_env(:dayzee, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dayzee.PubSub},
      # Start a worker by calling: Dayzee.Worker.start_link(arg)
      # {Dayzee.Worker, arg},
      # Start to serve requests, typically the last entry
      DayzeeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dayzee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DayzeeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
