defmodule TeamRecruitWeb.UserView do
  use TeamRecruitWeb, :view
  alias TeamRecruitWeb.{UserView, LinkView, TeamView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("social_accounts.json", %{social_accounts: social_accounts}) do
    %{
      name: social_accounts.name,
      avatar: social_accounts.avatar,
      uid: social_accounts.uid,
      provider: social_accounts.provider
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      nickname: user.nickname,
      bio: user.bio,
      avatar: user.avatar,
      teams: render_many(user.teams, TeamView, "team.json", as: :team),
      social_accounts: render_many(user.social_accounts, __MODULE__, "social_accounts.json", as: :social_accounts)
    }
  end

  def render("authenticated_user.json", %{user: user}) do
    %{id: user.id,
      nickname: user.nickname,
      bio: user.bio,
      avatar: user.avatar,
      social_accounts: render_many(user.social_accounts, __MODULE__, "social_accounts.json", as: :social_accounts)
    }
  end
end
