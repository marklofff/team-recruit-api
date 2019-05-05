# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :api,
  ecto_repos: [Api.Repo]

config :api_web,
  ecto_repos: [Api.Repo],
  generators: [context_app: :api]

# Configures the endpoint
config :api_web, ApiWeb.Endpoint,
  url: [host: "0.0.0.0"],
  secret_key_base: "9XxB5ZypS/uSzEM7a6D1m15VpFKYbYb8kYr1+Z7WFOcp6Xc/gMelc9iLQ4K7Vx1l",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :arc,
  # or Arc.Storage.Local
  storage: Arc.Storage.Local

config :api_web, ApiWeb.Guardian,
  issuer: "team_recruit",
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"

config :api_web, ApiWeb.Plugs.EnsureAuthenticatedPlug,
  module: ApiWeb.Guardian,
  error_handler: ApiWeb.Guardian.AuthErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
