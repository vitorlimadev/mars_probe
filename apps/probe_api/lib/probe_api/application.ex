defmodule ProbeApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ProbeApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ProbeApi.PubSub}
      # Start a worker by calling: ProbeApi.Worker.start_link(arg)
      # {ProbeApi.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ProbeApi.Supervisor)
  end
end
