defmodule TeamRecruitWeb.GameController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.Games
  alias TeamRecruit.Games.Game

  action_fallback TeamRecruitWeb.FallbackController

  def show(conn, _params) do
    games = Games.list_games()

    render(conn, "show.json", %{games: games})
  end
end
