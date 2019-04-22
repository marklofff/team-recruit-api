# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :team_recruit,
  ecto_repos: [TeamRecruit.Repo]

# Configures the endpoint
config :team_recruit, TeamRecruitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Z3izE6dOUxNcpywsKAZpHM7Q8kGePtbWtxduoqbOX+G3Dxy3PednLLvXiVhuLxrR",
  render_errors: [view: TeamRecruitWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TeamRecruit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
  storage: Arc.Storage.Local # or Arc.Storage.Local

config :team_recruit, TeamRecruit.Guardian,
  issuer: "team_recruit",
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"

config :team_recruit, TeamRecruit.Plugs.EnsureAuthenticatedPlug,
  module: TeamRecruit.Guardian,
  error_handler: TeamRecruit.Guardian.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
case Mix.env() do
  :test ->
    config :team_recruit,
      api_endpoint: "dev.devdox.net"
  :dev ->
    config :team_recruit,
      api_endpoint: "dev.devdox.net"
  :prod ->
    config :team_recruit,
      api_endpoint: "dev.devdox.net"
end

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    twitter: {Ueberauth.Strategy.Twitter, []},
    discord: {Ueberauth.Strategy.Discord, []},
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]},
    steam: {Ueberauth.Strategy.Steam, []},
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"]
    ]}
  ]

config :ueberauth, Ueberauth.Strategy.Steam,
  api_key: System.get_env("STEAM_API_KEY"),
  return_to: "http://localhost:3000/auth/steam/callback"
  
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: "http://localhost:3000/auth/google/callback"

config :ueberauth, Ueberauth.Strategy.Discord.OAuth,
  client_id: System.get_env("DISCORD_CLIENT_ID"),
  client_secret: System.get_env("DISCORD_CLIENT_SECRET"),
  redirect_uri: "http://localhost:3000/auth/discord/callback"

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  redirect_uri: "http://localhost:3000/auth/twitter/callback"

import_config "#{Mix.env()}.exs"
