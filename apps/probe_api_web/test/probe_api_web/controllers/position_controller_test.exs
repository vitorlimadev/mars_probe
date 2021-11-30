defmodule ProbeApiWeb.PositionControllerTest do
  use ProbeApiWeb.ConnCase

  setup %{conn: conn} do
    initial_position = ProbeApi.Positions.reset_probe()

    {:ok, position: initial_position, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all positions", %{conn: conn} do
      conn = get(conn, Routes.position_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "face" => "D",
                 "x" => 0,
                 "y" => 0
               }
             ]
    end
  end

  describe "create position" do
    test "creates a position relative to the last position", %{conn: conn} do
      conn = post(conn, Routes.position_path(conn, :create), movimentos: ["M", "GE", "M", "M", "GD", "GD"])

      assert %{
               "face" => "B",
               "x" => 2,
               "y" => 1
             } = json_response(conn, 201)["data"]
    end

    test "fails 422 when commands are invalid", %{conn: conn} do
      conn = post(conn, Routes.position_path(conn, :create), movimentos: ["M", "GT"])
      assert json_response(conn, 422)["errors"] != %{}

      conn = post(conn, Routes.position_path(conn, :create), movimentos: [])
      assert json_response(conn, 422)["errors"] != %{}

      conn = post(conn, Routes.position_path(conn, :create))
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "reset probe" do
    test "creates a new position at default location, reseting the probe", %{conn: conn} do
      conn = post(conn, Routes.position_path(conn, :reset_probe))

      assert %{
               "face" => "D",
               "x" => 0,
               "y" => 0
             } = json_response(conn, 201)["data"]
    end
  end

  describe "show current position" do
    test "gets the probe's current position", %{conn: conn} do
      conn = get(conn, Routes.position_path(conn, :show_current_position))

      assert %{
               "face" => "D",
               "x" => 0,
               "y" => 0
             } = json_response(conn, 200)["data"]
    end
  end
end
