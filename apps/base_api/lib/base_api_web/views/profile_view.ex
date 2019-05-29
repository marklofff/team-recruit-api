defmodule BaseApiWeb.ProfileView do
  use BaseApiWeb, :view

  def render("games_list.json", %{games: games}) do
    %{data: render_many(games, __MODULE__, "game.json", as: :game)}
  end

  def render("game.json", %{game: %{game: game}}) do
    %{
      full_name: game.full_name,
      app_id: game.app_id,
      id: game.id,
      provider: game.provider,
      short_name: game.short_name
    }
  end

  def render("game.json", %{game: game}) do
    %{
      full_name: game.full_name,
      app_id: game.app_id,
      id: game.id,
      provider: game.provider,
      short_name: game.short_name
    }
  end
end
