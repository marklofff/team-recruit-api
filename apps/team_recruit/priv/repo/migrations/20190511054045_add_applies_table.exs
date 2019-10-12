defmodule TeamRecruit.Repo.Migrations.AddAppliesTable do
  use Ecto.Migration

  def change do
    create table(:applies) do
      add :message, :text
      add :accepted, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:applies, [:user_id])
    create index(:applies, [:team_id])

  end
end
