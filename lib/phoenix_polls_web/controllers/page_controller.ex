defmodule PhoenixPollsWeb.PageController do
  use PhoenixPollsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
