defmodule ApiWeb.GameView do
  use ApiWeb, :view

  def render("show.json", %{games: games}) do
    %{data: render_many(games, __MODULE__, "game.json", as: :game)}
  end

  def render("game.json", %{game: game}) do
    %{
      full_name: game.full_name,
      app_id: game.app_id,
      id: game.id,
      provider: game.provider,
      short_name: game.short_name,
    }
  end
end
