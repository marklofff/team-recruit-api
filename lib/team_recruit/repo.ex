defmodule TeamRecruit.Repo do
  use Ecto.Repo,
    otp_app: :team_recruit,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
