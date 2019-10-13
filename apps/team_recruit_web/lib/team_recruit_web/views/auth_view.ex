defmodule TeamRecruitWeb.AuthView do
  use TeamRecruitWeb, :view

  def render("authenticated_user.json", %{token: token, user: user}) do
    %{token: token, user: render_one(user, TeamRecruitWeb.UserView, "authenticated_user.json")}
  end

  def render("connected_account.json", %{user: user}) do
    %{user: render_one(user, TeamRecruitWeb.UserView, "authenticated_user.json")}
  end
end
