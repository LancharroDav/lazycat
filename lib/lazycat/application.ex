defmodule Lazycat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LazycatWeb.Telemetry,
      # Start the Ecto repository
      Lazycat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lazycat.PubSub},
      # Start Finch
      {Finch, name: Lazycat.Finch},
      # Start the Endpoint (http/https)
      LazycatWeb.Endpoint
      # Start a worker by calling: Lazycat.Worker.start_link(arg)
      # {Lazycat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lazycat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LazycatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
