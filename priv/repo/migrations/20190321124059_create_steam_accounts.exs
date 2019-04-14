defmodule TeamRecruit.Repo.Migrations.CreateSteamAccounts do
  use Ecto.Migration

  def change do
    create table(:steam_accounts) do
      add :steamid, :string
      add :personaname, :string
      add :profileurl, :string
      add :avatar, :string
      add :avatarmedium, :string
      add :avatarfull, :string
      add :communityvisibilitystate, :integer
      add :profilestate, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:steam_accounts, [:user_id])
  end
end
