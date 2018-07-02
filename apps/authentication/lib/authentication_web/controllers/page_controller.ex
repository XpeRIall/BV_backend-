defmodule AuthenticationWeb.PageController do
  use AuthenticationWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
