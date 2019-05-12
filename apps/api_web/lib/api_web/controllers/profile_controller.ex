defmodule ApiWeb.ProfileController do
  use ApiWeb, :controller

  alias Api.Games
  alias Api.Profile
  alias Api.Profile.OwnedGames

  action_fallback ApiWeb.FallbackController

  def get_owned_games(%{assigns: %{user: user}} = conn, _params) do
    with games = Profile.list_owned_games(user.id) do
      render(conn, "games_list.json", %{games: games})
    end
  end

  def add_owned_games(conn, %{"game_id" => game_id}) do
    with user <- ApiWeb.Guardian.Plug.current_resource(conn) do
      case Profile.get_owned_game_by_game_id(user.id, game_id) do
        nil ->
          Profile.add_owned_game(user.id, game_id)
          json(conn, %{success: true})

        %OwnedGames{} = _game ->
          json(conn, %{success: false})
      end
    end
  end

  def delete_owned_games(conn, %{"user" => _params}) do
    with _user <- ApiWeb.Guardian.Plug.current_resource(conn) do
      conn
      |> json(%{success: true})
    end
  end

  def get_available_games(conn, _params) do
    with _user <- ApiWeb.Guardian.Plug.current_resource(conn),
         games <- Games.list_games() do
      render(conn, "games_list.json", %{games: games})
    end
  end
end
