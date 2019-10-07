defmodule TeamRecruitWeb.AuthView do
  use TeamRecruitWeb, :view

  def render("authenticated_user.json", %{token: token, user: user}) do
    %{
      user: render_one(user, TeamRecruitWeb.UserView, "user.json"),
      token: token
    }
  end
end
