defmodule Api.Repo.Migrations.CreateTeamsGames do
  use Ecto.Migration

  def change do
    create table(:teams_games, primary_key: false) do
      add :team_id, references(:teams, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :nothing)
    end

    create unique_index(:teams_games, [:team_id, :game_id])
  end
end
