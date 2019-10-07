defmodule TeamRecruitWeb.UserView do
  use TeamRecruitWeb, :view
  alias TeamRecruitWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      nickname: user.nickname,
      bio: user.bio,
      email: user.email}
  end
end
