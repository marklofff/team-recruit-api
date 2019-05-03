defmodule TeamRecruit.Repo.Migrations.CreateInvitation do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :message, :text
      add :accepted, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:invitations, [:user_id])
    create index(:invitations, [:team_id])
  end
end
