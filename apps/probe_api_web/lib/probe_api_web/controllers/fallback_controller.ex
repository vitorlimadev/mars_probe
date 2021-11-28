defmodule ProbeApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ProbeApiWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ProbeApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ProbeApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :impossible_movement}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ProbeApiWeb.PositionView)
    |> render("impossible_movement.json")
  end

  def call(conn, {:error, :invalid_commands}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ProbeApiWeb.PositionView)
    |> render("invalid_commands.json")
  end

  def call(conn, {:error, :no_probe}) do
    conn
    |> put_status(:conflict)
    |> put_view(ProbeApiWeb.PositionView)
    |> render("no_probe.json")
  end
end
