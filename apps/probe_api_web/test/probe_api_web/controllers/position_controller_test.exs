defmodule ProbeApiWeb.PositionControllerTest do
  use ProbeApiWeb.ConnCase

  import ProbeApi.PositionsFixtures

  alias ProbeApi.Positions.Position

  @create_attrs %{
    face: "D",
    x: 0,
    y: 0
  }
  @update_attrs %{
    face: "E",
    x: 1,
    y: 1
  }
  @invalid_attrs %{face: nil, x: nil, y: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all positions", %{conn: conn} do
      conn = get(conn, Routes.position_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create position" do
    test "renders position when data is valid", %{conn: conn} do
      conn = post(conn, Routes.position_path(conn, :create), position: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.position_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "face" => "some face",
               "x" => 42,
               "y" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.position_path(conn, :create), position: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update position" do
    setup [:create_position]

    test "renders position when data is valid", %{conn: conn, position: %Position{id: id} = position} do
      conn = put(conn, Routes.position_path(conn, :update, position), position: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.position_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "face" => "some updated face",
               "x" => 43,
               "y" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, position: position} do
      conn = put(conn, Routes.position_path(conn, :update, position), position: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete position" do
    setup [:create_position]

    test "deletes chosen position", %{conn: conn, position: position} do
      conn = delete(conn, Routes.position_path(conn, :delete, position))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.position_path(conn, :show, position))
      end
    end
  end

  defp create_position(_) do
    position = position_fixture()
    %{position: position}
  end
end
