# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :elevio, ElevioWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VCt+aDgPl70IabC7aBBjOQjWpv/viaE97MBkRvKOrw1WQJDhApWOxsShI/Nrq9jT",
  render_errors: [view: ElevioWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elevio.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :elevio, Elevio.API,
  elevio_base_url: System.get_env("ELEVIO_API_BASE_URL"),
  elevio_api_key: System.get_env("ELEVIO_API_KEY"),
  elevio_api_secret: System.get_env("ELEVIO_API_TOKEN")
