defmodule TeamRecruit.MixProject do
  use Mix.Project

  def project do
    [
      app: :team_recruit,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TeamRecruit.Application, []},
      extra_applications: [:logger, :runtime_tools, :arc_ecto, :edeliver,
        :ueberauth_steam,
        :ueberauth_google,
        :ueberauth_discord,
        :ueberauth_twitter
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.2"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:guardian, "~> 1.0"},
      {:ueberauth, "~> 0.6"},
      {:ueberauth_discord, "~> 0.3"},
      {:ueberauth_google, "~> 0.8"},
      {:ueberauth_steam, github: "qwexvf/ueberauth_steam"},
      {:ueberauth_twitter, "~> 0.2"},
      {:oauth, github: "tim/erlang-oauth"},
      {:argon2_elixir, "~> 2.0"},
      {:cors_plug, "~> 2.0"},
      {:steam_ex, "~> 0.2.0-alpha"},
      {:arc, "~> 0.11.0"},
      {:arc_ecto, "~> 0.11.1"},
      {:elixir_uuid, "~> 1.2"},
      {:edeliver, ">= 1.6.0"},
      {:distillery, "~> 2.0", warn_missing: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.3", only: :test},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      {:scribe, "~> 0.8", only: [:dev, :test]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
