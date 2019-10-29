defmodule TeamRecruitWeb.JoinRequestView do
  use TeamRecruitWeb, :view

  alias TeamRecruit.{TeamAvatar, TeamBackgroundImage, Avatar}

  def render("index.json", %{join_requests: join_requests}) do
    %{
      pagination: %{
        page_number: join_requests.page_number,
        page_size: join_requests.page_size,
        total_pages: join_requests.total_pages,
        total_entries: join_requests.total_entries
      },
      data: render_many(join_requests.entries, __MODULE__, "join_request.json")
    }
  end

  def render("show.json", %{join_request: join_request}) do
    %{data: render_one(join_request, __MODULE__, "join_request.json")}
  end

  def render("join_request.json", %{join_request: join_request}) do
    %{
      id: join_request.id,
      from_user: render_one(join_request.user, TeamRecruitWeb.UserView, "user.json"),
      to_team: render_one(join_request.team, TeamRecruitWeb.TeamView, "minimal_team.json")
    }
  end
end
