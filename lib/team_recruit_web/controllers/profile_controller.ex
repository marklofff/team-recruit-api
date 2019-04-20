defmodule TeamRecruitWeb.ProfileController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.{LinkManager, Guardian}
  alias TeamRecruit.Accounts.{User, SocialAccount}
  alias TeamRecruit.Games
  alias TeamRecruit.Games.Game
  alias TeamRecruit.Profile
  alias TeamRecruit.Profile.OwnedGames

  action_fallback TeamRecruitWeb.FallbackController

  def get_owned_games(%{assigns: %{user: user}} = conn, _params) do
    with games = Profile.list_owned_games(user.id) do
      render(conn, "games_list.json", %{games: games})
    end
  end

  def add_owned_games(conn, %{"game_id" => game_id}) do
    with user <- TeamRecruit.Guardian.Plug.current_resource(conn) do
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
    with user <- TeamRecruit.Guardian.Plug.current_resource(conn) do
      conn
      |> json(%{success: true})
    end
  end

  def get_available_games(conn, _params) do
    with _user <- TeamRecruit.Guardian.Plug.current_resource(conn),
         games <- Games.list_games() do
      render(conn, "games_list.json", %{games: games})
    end
  end
end
