defmodule ApiWeb.InvitationController do
  use ApiWeb, :controller

  alias Api.TeamManager
  alias Api.Notifications
  alias Api.Notifications.Invitation

  action_fallback ApiWeb.FallbackController

  def index(%{assigns: %{user: user}} = conn, _params) do
    invitations = Notifications.list_invitation(user.id)
    render(conn, "index.json", invitations: invitations)
  end

  def create(%{assigns: %{user: user}} = conn, params) do
    params = Map.put(params, "user", user)

    with {:ok, %Invitation{} = invitation} <- Notifications.create_invitation(params) do
      ApiWeb.Endpoint.broadcast!(
        "notification:" <> to_string(invitation.user_id),
        "invitatio:new",
        Notifications.create_payload(invitation)
      )

      conn
      |> put_status(:created)
      |> render("show.json", invitation: invitation)
    end
  end

  def accept_invitation(%{assigns: %{user: user}} = conn, params) do
    invitation = Notifications.get_invitation!(params["id"])
    IO.inspect(invitation)

    with true <- Notifications.check_user(invitation, user),
         {:ok, %Invitation{} = invitation} <-
           Notifications.update_invitation(invitation, %{accepted: true}),
         {:ok, _member} <- TeamManager.add_member(invitation.team_id, invitation.user_id) do
      conn
      |> render("show.json", invitation: invitation)
    end
  end

  def show(conn, %{"id" => id}) do
    invites = Notifications.get_invites!(id)
    render(conn, "show.json", invites: invites)
  end

  def update(conn, %{"id" => id, "invites" => invites_params}) do
    invites = Notifications.get_invites!(id)

    with {:ok, %Invitation{} = invites} <- Notifications.update_invites(invites, invites_params) do
      render(conn, "show.json", invites: invites)
    end
  end

  def delete(conn, %{"id" => id}) do
    invites = Notifications.get_invites!(id)

    with {:ok, %Invitation{}} <- Notifications.delete_invites(invites) do
      send_resp(conn, :no_content, "")
    end
  end
end
