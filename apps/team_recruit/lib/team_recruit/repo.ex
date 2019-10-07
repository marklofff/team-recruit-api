defmodule TeamRecruit.Repo do
  use Ecto.Repo,
    otp_app: :team_recruit,
    adapter: Ecto.Adapters.Postgres
end
