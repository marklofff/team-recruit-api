defmodule Database.MixProject do
  use Mix.Project

  def project do
    [
      app: :database,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :arc_ecto, :httpoison],
      mod: {Database.Application, []},
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.0"},
      {:guardian, "~> 1.0"},
      {:guardian_db, "~> 2.0"},
      {:argon2_elixir, "~> 2.0"},
      {:elixir_uuid, "~> 1.2"},
      {:arc, "~> 0.11.0"},
      {:httpoison, "~> 1.4"},
      {:ecto_enum, "~> 1.2"},
      {:arc_ecto, github: "qwexvf/arc_ecto"},
      {:scrivener_ecto, "~> 2.0"},
      {:image_uploader, in_umbrella: true}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create — quiet", "ecto.migrate", "test"]
    ]
  end
end
