use Mix.Config

config :database, Database.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "team_recruit_dev",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool_size: 10
