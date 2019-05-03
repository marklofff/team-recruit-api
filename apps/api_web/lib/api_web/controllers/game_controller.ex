defmodule ApiWeb.GameController do
  use ApiWeb, :controller

  alias Api.Games
  alias Api.Games.Game

  action_fallback ApiWeb.FallbackController

  def show(conn, _params) do
    games = Games.list_games()

    render(conn, "show.json", %{games: games})
  end
end
