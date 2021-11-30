defmodule ProbeApi.PositionsTest do
  use ProbeApi.DataCase

  alias ProbeApi.Positions
  alias ProbeApi.Positions.Position

  setup do
    {:ok, position} = Positions.create_position(%{x: 0, y: 0, face: "D"})

    {:ok, pos: position}
  end

  describe "create_position/1" do
    test "creates positions facing all directions" do
      # Right
      assert {:ok,
              %Position{
                face: "D",
                x: 0,
                y: 0
              }} = Positions.create_position(%{x: 0, y: 0, face: "D"})

      # Left
      assert {:ok,
              %Position{
                face: "E",
                x: 0,
                y: 0
              }} = Positions.create_position(%{x: 0, y: 0, face: "E"})

      # Up
      assert {:ok,
              %Position{
                face: "C",
                x: 0,
                y: 0
              }} = Positions.create_position(%{x: 0, y: 0, face: "C"})

      # Down
      assert {:ok,
              %Position{
                face: "D",
                x: 0,
                y: 0
              }} = Positions.create_position(%{x: 0, y: 0, face: "D"})
    end

    test "fails if matrix location is unreachable" do
      assert {:error,
              %Ecto.Changeset{
                errors: [
                  x:
                    {"must be less than or equal to %{number}",
                     [validation: :number, kind: :less_than_or_equal_to, number: 4]}
                ]
              }} = Positions.create_position(%{x: 5, y: 0, face: "D"})

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  y:
                    {"must be less than or equal to %{number}",
                     [validation: :number, kind: :less_than_or_equal_to, number: 4]}
                ]
              }} = Positions.create_position(%{x: 0, y: 5, face: "D"})

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  x:
                    {"must be greater than or equal to %{number}",
                     [validation: :number, kind: :greater_than_or_equal_to, number: 0]}
                ]
              }} = Positions.create_position(%{x: -1, y: 0, face: "D"})

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  y:
                    {"must be greater than or equal to %{number}",
                     [validation: :number, kind: :greater_than_or_equal_to, number: 0]}
                ]
              }} = Positions.create_position(%{x: 0, y: -1, face: "D"})
    end

    test "fails if face is invalid" do
      assert {:error, %Ecto.Changeset{}} = Positions.create_position(%{x: 5, y: 0, face: "U"})
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Positions.create_position(%{invalid: "data"})
    end
  end

  describe "list_positions/0" do
    test "list_positions/0 returns all positions asc", %{pos: pos} do
      {:ok, pos2} = Positions.create_position(%{x: 1, y: 0, face: "D"})
      {:ok, pos3} = Positions.create_position(%{x: 2, y: 0, face: "D"})
      {:ok, pos4} = Positions.create_position(%{x: 3, y: 0, face: "D"})

      assert Positions.list_positions() == [pos, pos2, pos3, pos4]
    end

  end

  describe "reset_probe/0" do
    test "reset_probe/0 lands the probe" do
      assert {:ok,
              %Position{
                face: "D",
                x: 0,
                y: 0
              }} = Positions.reset_probe()
    end
  end
end
