defmodule TeamRecruit.TeamManager.UserGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_games" do
    belongs_to :user, TeamRecruit.Accounts.User
    belongs_to :game, TeamRecruit.Games.Game
  end

  @doc false
  def changeset(team_game, attrs) do
    team_game
    |> cast(attrs, [])
    |> validate_required([])
  end
end
