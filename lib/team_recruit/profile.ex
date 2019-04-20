defmodule TeamRecruit.Profile do
  @moduledoc """
  TODO: Profile
  """
  import Ecto.Query, warn: false
  alias TeamRecruit.Repo
  alias TeamRecruit.Profile.OwnedGames

  def list_owned_games(user_id) do
    query = from g in OwnedGames,
      where: g.user_id == ^user_id,
      preload: [:user, :game]

    Repo.all(query)
  end

  def get_owned_game_by_game_id(user_id, game_id) do
    query = from g in OwnedGames,
      where: g.user_id == ^user_id and g.game_id == ^game_id
    Repo.one(query)
  end

  def add_owned_game(user_id, game_id) do
    %OwnedGames{user_id: user_id, game_id: game_id}
    |> OwnedGames.changeset(%{})
    |> Repo.insert()
  end

  def delete_owned_game(%OwnedGames{} = owned_games) do
    Repo.delete(owned_games)
  end

  def change_owned_game(%OwnedGames{} = owned_games) do
    OwnedGames.changeset(owned_games, %{})
  end
end
