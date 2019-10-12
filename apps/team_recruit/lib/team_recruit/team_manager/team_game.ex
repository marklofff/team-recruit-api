defmodule TeamRecruit.TeamManager.TeamGame do
  @moduledoc """
  TeamGame
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams_games" do
  end

  @doc false
  def changeset(team_game, attrs) do
    team_game
    |> cast(attrs, [])
    |> validate_required([])
  end
end
