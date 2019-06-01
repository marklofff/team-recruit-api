defmodule Database.Repo.Migrations.CreateOwnedGames do
  use Ecto.Migration

  def change do
    create table(:owned_games) do
      add :user_id, references(:users, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:owned_games, [:user_id])
    create index(:owned_games, [:game_id])
  end
end
