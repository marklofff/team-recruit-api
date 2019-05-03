defmodule Api.Games do
  @moduledoc """
  Games
  """
  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Games.Game

  def list_games do
    Repo.all(Game)
  end

  def get_game_by_app_id(id), do: Repo.get_by(Game, app_id: id)
  def get_game!(id), do: Repo.get!(Game, id)

  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  def change_game(%Game{} = game) do
    Game.changeset(game, %{})
  end
end
