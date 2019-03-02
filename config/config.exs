# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :cellar, CellarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GvRPOtR3hpOi9HgojG7B7gjlrUDpDEnLgqI7Yw3AdVKqbhBLjjsNju7mvpqkPpF7",
  render_errors: [view: CellarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cellar.PubSub, adapter: Phoenix.PubSub.PG2]

config :cellar, Cellar,
  source_file: "/data/cellar.csv",
  name: "Hez's Cellar"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
