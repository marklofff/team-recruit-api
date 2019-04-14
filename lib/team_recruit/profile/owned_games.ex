defmodule TeamRecruit.Profile.OwnedGames do
  use Ecto.Schema
  import Ecto.Changeset

  schema "owned_games" do
    belongs_to :user, TeamRecruit.Accounts.User
    belongs_to :game, TeamRecruit.Games.Game

    timestamps()
  end

  @doc false
  def changeset(owned_games, attrs) do
    owned_games
    |> cast(attrs, [])
    |> validate_required([])
  end
end
