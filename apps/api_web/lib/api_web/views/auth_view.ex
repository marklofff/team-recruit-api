defmodule ApiWeb.AuthView do
  use ApiWeb, :view

  def render("authenticated_user.json", %{token: token, user: user}) do
    %{token: token,
      user: render_one(user, ApiWeb.UserView, "authenticated_user.json")}
  end

  def render("connected_account.json", %{user: user}) do
    %{user: render_one(user, ApiWeb.UserView, "authenticated_user.json")}
  end
end
