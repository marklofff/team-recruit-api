defmodule BaseApiWeb.AwardView do
  use BaseApiWeb, :view

  def render("index.json", %{awards: awards}) do
    %{data: render_many(awards, __MODULE__, "award.json")}
  end

  def render("show.json", %{award: award}) do
    %{data: render_one(award, __MODULE__, "award.json")}
  end

  def render("team.json", %{award: award}) do
    %{id: award.id, title: award.title, rank: award.rank, date: award.date}
  end
end
