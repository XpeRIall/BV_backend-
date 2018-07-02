# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :authentication,
  namespace: Authentication,
  ecto_repos: [Authentication.Repo]

# Configures the endpoint
config :authentication, AuthenticationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4LDnLwcVoI7g7pIca/dXX8cOo3gs4zFDb6HNMB8WBv+OwWSRdDP0oKADvknurZYc",
  render_errors: [view: AuthenticationWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Authentication.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
