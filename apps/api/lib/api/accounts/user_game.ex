defmodule Api.TeamManager.UserGame do
  @moduledoc """
  UserGame
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_games" do
    belongs_to :user, Api.Accounts.User
    belongs_to :game, Api.Games.Game
  end

  @doc false
  def changeset(team_game, attrs) do
    team_game
    |> cast(attrs, [])
    |> validate_required([])
  end
end
