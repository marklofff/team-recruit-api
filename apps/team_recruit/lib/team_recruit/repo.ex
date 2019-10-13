defmodule TeamRecruit.Repo do
  use Ecto.Repo,
    otp_app: :team_recruit,
    adapter: Ecto.Adapters.Postgres,
    show_sensitive_data_on_connection_error: true

  use Scrivener, page_size: 10
end
