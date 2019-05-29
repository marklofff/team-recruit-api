defmodule Database.Repo.Migrations.CreateUserGames do
  use Ecto.Migration

  def change do
    create table(:user_games, primary_key: false) do
      add :user_id, references(:users, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :nothing)
    end

    create unique_index(:user_games, [:user_id, :game_id])
  end
end
