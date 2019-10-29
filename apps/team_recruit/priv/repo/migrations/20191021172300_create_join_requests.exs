defmodule TeamRecruit.Repo.Migrations.CreateJoinRequests do
  use Ecto.Migration

  def change do
    create table(:join_requests) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:join_requests, [:user_id, :team_id], name: :unique_user_team)
  end
end
