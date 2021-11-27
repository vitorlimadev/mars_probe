defmodule ProbeApi.PositionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProbeApi.Positions` context.
  """

  @doc """
  Generate a position.
  """
  def position_fixture(attrs \\ %{}) do
    {:ok, position} =
      attrs
      |> Enum.into(%{
        face: "some face",
        x: 42,
        y: 42
      })
      |> ProbeApi.Positions.create_position()

    position
  end
end
