defmodule ProbeApiWeb.PositionView do
  use ProbeApiWeb, :view
  alias ProbeApiWeb.PositionView

  def render("index.json", %{positions: positions}) do
    %{data: render_many(positions, PositionView, "position.json")}
  end

  def render("show.json", %{position: position}) do
    %{data: render_one(position, PositionView, "position.json")}
  end

  def render("position.json", %{position: position}) do
    %{
      x: position.x,
      y: position.y,
      face: position.face
    }
  end

  def render("invalid_commands.json", _) do
    %{erro: "Comandos inválidos"}
  end

  def render("impossible_movement.json", _) do
    %{erro: "Movimento impossível"}
  end
end
