defmodule ProbeApiWeb.PositionController do
  use ProbeApiWeb, :controller

  alias ProbeApi.Commands
  alias ProbeApi.Positions
  alias ProbeApi.Positions.Position

  action_fallback ProbeApiWeb.FallbackController

  def index(conn, _params) do
    positions = Positions.list_positions()
    render(conn, "index.json", positions: positions)
  end

  def reset_probe(conn, _params) do
    {:ok, position} = Positions.reset_probe
    render(conn, "show.json", position: position)
  end

  def create(conn, %{"movimentos" => commands}) do
    with {:ok, %Position{} = position} <- Commands.run_commands(commands) do
      conn
      |> put_status(:created)
      |> render("show.json", position: position)
    end
  end

  def show_current_position(conn, _params) do
    position = Positions.get_current_position!()
    render(conn, "show.json", position: position)
  end
end
