defmodule ProbeApiWeb.PageController do
  use ProbeApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
