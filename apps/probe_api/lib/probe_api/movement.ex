defmodule ProbeApi.Movement do
  @spec move(map()) :: map()
  def move(%{face: "D"} = current_position),
    do: Map.put(current_position, :y, current_position.y + 1)

  def move(%{face: "E"} = current_position),
    do: Map.put(current_position, :y, current_position.y - 1)

  def move(%{face: "C"} = current_position),
    do: Map.put(current_position, :x, current_position.x + 1)

  def move(%{face: "B"} = current_position),
    do: Map.put(current_position, :x, current_position.x - 1)
end
