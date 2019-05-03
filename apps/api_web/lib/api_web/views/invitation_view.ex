defmodule ApiWeb.InvitationView do
  use ApiWeb, :view

  def render("index.json", %{invitations: invitations}) do
    %{data: render_many(invitations, __MODULE__, "invitation.json", as: :invitation)}
  end

  def render("show.json", %{invitation: invitation}) do
    %{data: render_one(invitation, __MODULE__, "invitation.json")}
  end

  def render("invitation.json", %{invitation: invitation}) do
    %{id: invitation.id,
      team: %{
        id: invitation.team.id,
        name: invitation.team.name,
        user: %{
          id: invitation.team.user.id,
          nickname: invitation.team.user.nickname,
          avatar: invitation.team.user.avatar
        }
      },
      accepted: invitation.accepted}
  end
end
