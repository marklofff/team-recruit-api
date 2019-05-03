defmodule TeamRecruitWeb.TeamView do
  use TeamRecruitWeb, :view

  def render("index.json", %{teams: teams}) do
    %{
      pagination: %{
        page_number: teams.page_number,
        page_size: teams.page_size,
        total_pages: teams.total_pages,
        total_entries: teams.total_entries
      },
      data: render_many(teams.entries, __MODULE__, "minimal_team.json"),
    }
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, __MODULE__, "team.json")}
  end

  def render("minimal_team.json", %{team: team}) do
    IO.inspect team
    %{id: team.id,
      name: team.name,
      tag: team.tag,
      bio: team.bio,
      avatar: TeamRecruit.TeamAvatar.url({team.avatar, team}, :thumb),
      leader: render_one(team.user, TeamRecruitWeb.UserView, "user.json"),
    }
  end

  def render("team.json", %{team: team}) do
    IO.inspect team
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
      members: Enum.count(team.members),
      awards: render_many(team.awards, TeamRecruitWeb.AwardsView, "award.json"),
    }
  end

  def render("member_user.json", %{members: members}) do
    %{id: members.user.id,
      nickname: members.user.nickname,
      bio: members.user.bio,
      avatar: TeamRecruit.Avatar.url({members.user.avatar, members.user}, :original),
      uuid: members.user.uuid,
      games: render_many(members.user.games, TeamRecruitWeb.GameView, "game.json"),
    }
  end
end
