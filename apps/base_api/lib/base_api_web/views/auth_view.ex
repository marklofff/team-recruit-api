defmodule BaseApiWeb.AuthView do
  use BaseApiWeb, :view

  def render("authenticated_user.json", %{token: token, user: user}) do
    %{token: token, user: render_one(user, BaseApiWeb.UserView, "authenticated_user.json")}
  end

  def render("connected_account.json", %{user: user}) do
    %{user: render_one(user, BaseApiWeb.UserView, "authenticated_user.json")}
  end
end
