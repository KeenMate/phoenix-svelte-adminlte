defmodule PhoenixSvelteAdminlte.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixSvelteAdminlteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixSvelteAdminlte.PubSub},
      # Start the Endpoint (http/https)
      PhoenixSvelteAdminlteWeb.Endpoint,
      PhoenixSvelteAdminlte.Repo,
      PhoenixSvelteAdminlte.Helpers.MsgHelpers,
      PhoenixSvelteAdminlte.Image.Supervisor,
      PhoenixSvelteAdminlteWeb.PhotoQueueDispatcher,
      PhoenixSvelteAdminlte.Scheduler
      # Start a worker by calling: PhoenixSvelteAdminlte.Worker.start_link(arg)
      # {PhoenixSvelteAdminlte.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixSvelteAdminlte.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixSvelteAdminlteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
