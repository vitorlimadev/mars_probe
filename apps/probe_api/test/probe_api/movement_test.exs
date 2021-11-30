defmodule ProbeApi.MovementTest do
  use ProbeApi.DataCase

  alias ProbeApi.Movement

  describe "move/1" do
    test "moves the probe facing right" do
      position = %{face: "D", x: 0, y: 0}

      assert %{
                face: "D",
                x: 0,
                y: 1
              } = Movement.move(position)
    end

    test "moves the probe facing left" do
      position = %{face: "E", x: 0, y: 4}

      assert %{
                face: "E",
                x: 0,
                y: 3
              } = Movement.move(position)
    end

    test "moves the probe facing up" do
      position = %{face: "C", x: 0, y: 0}

      assert %{
                face: "C",
                x: 1,
                y: 0
              } = Movement.move(position)
    end

    test "moves the probe facing down" do
      position = %{face: "B", x: 4, y: 0}

      assert %{
                face: "B",
                x: 3,
                y: 0
              } = Movement.move(position)
    end
  end
end
