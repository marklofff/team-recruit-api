defmodule ApiWeb.ProfileController do
  use ApiWeb, :controller

  alias Api.{LinkManager, Guardian}
  alias Api.Accounts.{User, SocialAccount}
  alias Api.Games
  alias Api.Games.Game
  alias Api.Profile
  alias Api.Profile.OwnedGames

  action_fallback ApiWeb.FallbackController

  def get_owned_games(%{assigns: %{user: user}} = conn, _params) do
    with games = Profile.list_owned_games(user.id) do
      render(conn, "games_list.json", %{games: games})
    end
  end

  def add_owned_games(conn, %{"game_id" => game_id}) do
    with user <- Api.Guardian.Plug.current_resource(conn) do
      game =
        case Profile.get_owned_game_by_game_id(user.id, game_id) do
          nil ->
            Profile.add_owned_game(user.id, game_id)

          %OwnedGames{} = game ->
            game
        end

      json(conn, %{success: true})
    end
  end

  def delete_owned_games(conn, %{"user" => _params}) do
    with user <- Api.Guardian.Plug.current_resource(conn) do
      conn
      |> json(%{success: true})
    end
  end

  def get_available_games(conn, _params) do
    with _user <- Api.Guardian.Plug.current_resource(conn),
         games <- Games.list_games() do
      render(conn, "games_list.json", %{games: games})
    end
  end
end
