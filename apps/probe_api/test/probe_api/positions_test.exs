defmodule ProbeApi.PositionsTest do
  use ProbeApi.DataCase

  alias ProbeApi.Positions

  describe "positions" do
    alias ProbeApi.Positions.Position

    import ProbeApi.PositionsFixtures

    @invalid_attrs %{face: nil, x: nil, y: nil}

    test "list_positions/0 returns all positions" do
      position = position_fixture()
      assert Positions.list_positions() == [position]
    end

    test "get_position!/1 returns the position with given id" do
      position = position_fixture()
      assert Positions.get_position!(position.id) == position
    end

    test "create_position/1 with valid data creates a position" do
      valid_attrs = %{face: "some face", x: 42, y: 42}

      assert {:ok, %Position{} = position} = Positions.create_position(valid_attrs)
      assert position.face == "some face"
      assert position.x == 42
      assert position.y == 42
    end

    test "create_position/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Positions.create_position(@invalid_attrs)
    end

    test "update_position/2 with valid data updates the position" do
      position = position_fixture()
      update_attrs = %{face: "some updated face", x: 43, y: 43}

      assert {:ok, %Position{} = position} = Positions.update_position(position, update_attrs)
      assert position.face == "some updated face"
      assert position.x == 43
      assert position.y == 43
    end

    test "update_position/2 with invalid data returns error changeset" do
      position = position_fixture()
      assert {:error, %Ecto.Changeset{}} = Positions.update_position(position, @invalid_attrs)
      assert position == Positions.get_position!(position.id)
    end

    test "delete_position/1 deletes the position" do
      position = position_fixture()
      assert {:ok, %Position{}} = Positions.delete_position(position)
      assert_raise Ecto.NoResultsError, fn -> Positions.get_position!(position.id) end
    end

    test "change_position/1 returns a position changeset" do
      position = position_fixture()
      assert %Ecto.Changeset{} = Positions.change_position(position)
    end
  end
end
