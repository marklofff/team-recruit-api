defmodule BaseApiWeb.GameController do
  use BaseApiWeb, :controller

  alias Api.Games

  action_fallback BaseApiWeb.FallbackController

  def show(conn, _params) do
    games = Games.list_games()

    render(conn, "show.json", %{games: games})
  end
end
