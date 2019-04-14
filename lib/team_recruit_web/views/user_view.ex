defmodule TeamRecruitWeb.UserView do
  use TeamRecruitWeb, :view
  alias TeamRecruitWeb.{UserView, LinkView, TeamView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("login.json", %{user: user, token: token}) do
    %{
      data: render_one(user, UserView, "minimal_user.json"),
      token: token
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      password: user.password,
      email: user.email,
      userId: user.userId,
      teams: render_many(user.teams, TeamView, "team.json", as: :team)
    }
  end
  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      password: user.password,
      email: user.email,
      userId: user.userId,
      teams: render_many(user.teams, TeamView, "team.json", as: :team)
    }
  end

  def render("minimal_user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      userId: user.userId,
    }
  end
end
