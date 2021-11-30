defmodule ProbeApi.CommandsTest do
  use ProbeApi.DataCase

  alias ProbeApi.Commands
  alias ProbeApi.Positions
  alias ProbeApi.Positions.Position

  describe "run_commands/1" do
    test "moves correctly if target matrix location is reachable" do
      Positions.reset_probe()

      params = ["M", "M", "M", "M"]

      assert {:ok,
              %Position{
                face: "D",
                x: 0,
                y: 4
              }} = Commands.run_commands(params)
    end

    test "fails if target matrix location is unreachable" do
      Positions.reset_probe()

      params = ["M", "M", "M", "M", "M"]

      assert {:error, :impossible_movement} = Commands.run_commands(params)
    end

    test "fails if a command is invalid" do
      Positions.reset_probe()

      params = ["M", "m"]

      assert {:error, :invalid_commands} = Commands.run_commands(params)
    end

    test "fails if the probe didn't land yet" do
      assert {:error, :no_probe} = Commands.run_commands(["M"])
    end
  end
end
