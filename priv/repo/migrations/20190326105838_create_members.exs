defmodule TeamRecruit.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:members, [:user_id])
    create index(:members, [:team_id])
  end
end
