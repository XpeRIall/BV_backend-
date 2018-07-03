defmodule AuthenticationWeb.Router do
  use AuthenticationWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", AuthenticationWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuthenticationWeb do
  #   pipe_through :api
  # end

  forward("/api", Absinthe.Plug, schema: Authentication.Schema)
  forward("/graph", Absinthe.Plug.GraphiQL, schema: Authentication.Schema)
end
