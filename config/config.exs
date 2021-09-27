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
  pubsub_server: Cellar.PubSub

config :cellar, Cellar,
  source_file: "/data/cellar.csv",
  name: "Hez's Cellar"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
