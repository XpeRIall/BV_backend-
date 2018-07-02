defmodule CommentariesApiWeb.PageController do
  use CommentariesApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
