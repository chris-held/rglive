# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rglive,
  ecto_repos: [Rglive.Repo]

# Configures the endpoint
config :rglive, RgliveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hdHb9p99qUy4vDMkLAXhMzKbLsSRyuY7MiZsBu2A3FajBd7XW0fPpQ4H5V253nmw",
  render_errors: [view: RgliveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Rglive.PubSub,
  live_view: [signing_salt: "mXSgmWF5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
