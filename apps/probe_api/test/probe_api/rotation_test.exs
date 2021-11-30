defmodule ProbeApi.RotationTest do
  use ProbeApi.DataCase

  alias ProbeApi.Rotation

  describe "rotate/1" do
    test "rotates the probe from right to up" do
      position = %{face: "D", x: 0, y: 0}

      assert %{
                face: "C",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GE")
    end

    test "rotates the probe from right to down" do
      position = %{face: "D", x: 0, y: 0}

      assert %{
                face: "B",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GD")
    end

    test "rotates the probe from left to down" do
      position = %{face: "E", x: 0, y: 0}

      assert %{
                face: "B",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GE")
    end

    test "rotates the probe from left to up" do
      position = %{face: "E", x: 0, y: 0}

      assert %{
                face: "C",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GD")
    end

    test "rotates the probe from up to left" do
      position = %{face: "C", x: 0, y: 0}

      assert %{
                face: "E",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GE")
    end

    test "rotates the probe from up to right" do
      position = %{face: "C", x: 0, y: 0}

      assert %{
                face: "D",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GD")
    end

    test "rotates the probe from down to right" do
      position = %{face: "B", x: 0, y: 0}

      assert %{
                face: "D",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GE")
    end

    test "rotates the probe from down to left" do
      position = %{face: "B", x: 0, y: 0}

      assert %{
                face: "E",
                x: 0,
                y: 0
              } = Rotation.rotate(position, "GD")
    end
  end
end
