defmodule ProbeApiWeb.PositionController do
  use ProbeApiWeb, :controller

  alias ProbeApi.Commands
  alias ProbeApi.Positions
  alias ProbeApi.Positions.Position

  action_fallback ProbeApiWeb.FallbackController

  def index(conn, cursor) do
    render(conn, "index.json", positions: Positions.list_positions(cursor))
  end

  def reset_probe(conn, _params) do
    {:ok, position} = Positions.reset_probe()

    conn
    |> put_status(:created)
    |> render("show.json", position: position)
  end

  def create(conn, %{"movimentos" => commands}) do
    with {:ok, %Position{} = position} <- Commands.run_commands(commands) do
      conn
      |> put_status(:created)
      |> render("show.json", position: position)
    end
  end

  def create(conn, _params) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ProbeApiWeb.PositionView)
    |> render("invalid_commands.json")
  end

  def show_current_position(conn, _params) do
    with {:ok, position} <- Positions.get_current_position() do
      render(conn, "show.json", position: position)
    end
  end
end
