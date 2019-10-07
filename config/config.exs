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
config :team_recruit,
  ecto_repos: [TeamRecruit.Repo]

config :team_recruit_web,
  ecto_repos: [TeamRecruit.Repo],
  generators: [context_app: :team_recruit]

# Configures the endpoint
config :team_recruit_web, TeamRecruitWeb.Endpoint,
  url: [host: "0.0.0.0"],
  secret_key_base: "y0watH9Qb2ucR9ljjBDo7f+4jOoCVrXdekszIOTtpvZpsXjpkpuA8jUiDg7333v2",
  render_errors: [view: TeamRecruitWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TeamRecruitWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
