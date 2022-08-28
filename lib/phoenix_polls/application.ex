defmodule PhoenixPolls.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhoenixPolls.Repo,
      # Start the Telemetry supervisor
      PhoenixPollsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixPolls.PubSub},
      # Start the Endpoint (http/https)
      PhoenixPollsWeb.Endpoint
      # Start a worker by calling: PhoenixPolls.Worker.start_link(arg)
      # {PhoenixPolls.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixPolls.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixPollsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
