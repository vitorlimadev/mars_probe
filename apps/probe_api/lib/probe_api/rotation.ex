defmodule ProbeApi.Rotation do
  @moduledoc """
  See ProbeApi.Rotation.rotate/2
  """

  @doc """
  Recieves a representation of a Position and rotates it
  accordingly.
  """
  @spec rotate(map(), binary()) :: map()
  def rotate(%{face: "D"} = current_position, "GE"),
    do: Map.put(current_position, :face, "C")

  def rotate(%{face: "D"} = current_position, "GD"),
    do: Map.put(current_position, :face, "B")

  def rotate(%{face: "E"} = current_position, "GE"),
    do: Map.put(current_position, :face, "B")

  def rotate(%{face: "E"} = current_position, "GD"),
    do: Map.put(current_position, :face, "C")

  def rotate(%{face: "C"} = current_position, "GE"),
    do: Map.put(current_position, :face, "E")

  def rotate(%{face: "C"} = current_position, "GD"),
    do: Map.put(current_position, :face, "D")

  def rotate(%{face: "B"} = current_position, "GE"),
    do: Map.put(current_position, :face, "D")

  def rotate(%{face: "B"} = current_position, "GD"),
    do: Map.put(current_position, :face, "E")
end
