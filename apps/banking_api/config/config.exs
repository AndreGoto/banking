# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :banking_api, BankingApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PugM3xoo4n1TsnjdLu18a+mYh+b7OmhiSbZ6WKEBzgUwUnungs/LjZg80/MXBNDy",
  render_errors: [view: BankingApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankingApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :banking_api, BankingApiWeb.Auth.Guardian,
  issuer: "banking_api",
  secret_key: "4p9pCzcHDRx/6udKwNyWhdRA4VnTwVP2ipRoXEH9GhZxFz4cW5VHyKWbPqU/seAX"
