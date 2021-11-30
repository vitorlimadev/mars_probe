defmodule ProbeApiWeb.PositionView do
  use ProbeApiWeb, :view
  alias ProbeApiWeb.PositionView

  def render("index.json", %{positions: positions}) do
    %{
      cursor: %{
        after: positions.metadata.after,
        before: positions.metadata.before,
        data: render_many(positions.entries, PositionView, "position.json")
      }
    }
  end

  def render("show.json", %{position: position}) do
    %{data: render_one(position, PositionView, "position.json")}
  end

  def render("position.json", %{position: position}) do
    %{
      id: position.id,
      x: position.x,
      y: position.y,
      face: position.face,
      inserted_at: position.inserted_at
    }
  end

  def render("invalid_commands.json", _) do
    %{erro: "Comandos inválidos"}
  end

  def render("impossible_movement.json", _) do
    %{erro: "Movimento impossível"}
  end

  def render("no_probe.json", _) do
    %{
      erro:
        "A sonda não foi pousada em marte. Pouse-a com uma requisição POST em /api/v1/reset_probe"
    }
  end
end
