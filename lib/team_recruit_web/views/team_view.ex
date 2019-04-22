defmodule TeamRecruitWeb.TeamView do
  use TeamRecruitWeb, :view
  alias TeamRecruitWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{
      pagination: %{
        page_number: teams.page_number,
        page_size: teams.page_size,
        total_pages: teams.total_pages,
        total_entries: teams.total_entries
      },
      data: render_many(teams.entries, TeamView, "team.json"),
    }
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name,
      tag: team.tag,
      bio: team.bio,
      wanted_num: team.wanted_num,
      views: team.views,
      wanted: team.wanted,
      nation: team.nation,
      avatar: TeamRecruit.TeamAvatar.url({team.avatar, team}, :thumb),
      language: team.language,
      inserted_at: team.inserted_at,
      leader: render_one(team.user, TeamRecruitWeb.UserView, "user.json"),
      games: render_many(team.games, TeamRecruitWeb.GameView, "game.json"),
      awards: render_many(team.awards, TeamRecruitWeb.AwardsView, "award.json"),
    }
  end
end
