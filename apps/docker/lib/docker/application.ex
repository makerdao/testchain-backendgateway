defmodule Staxx.Docker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Staxx.Docker.Worker.start_link(arg)
      {Registry, keys: :unique, name: Staxx.Docker.ContainerRegistry},
      Staxx.Docker.PortMapper,
      Staxx.Docker.EventListener,
      Staxx.Docker.NetworkRemover
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Staxx.Docker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
