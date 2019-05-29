defmodule BaseApiWeb.ApplyController do
  use BaseApiWeb, :controller

  alias Api.TeamManager
  alias Api.UserManager
  alias Api.Notifications.Apply

  action_fallback BaseApiWeb.FallbackController

  def index(%{assigns: %{user: user}} = conn, _params) do
    applies = UserManager.list_apply(user.id)
    render(conn, "index.json", applies: applies)
  end

  def create(%{assigns: %{user: user}} = conn, params) do
    params = Map.put(params, "user", user)

    with {:ok, %Apply{} = apply} <- UserManager.create_apply(params) do
      BaseApi.Endpoint.broadcast!(
        "notification:" <> to_string(apply.user_id),
        "apply:new",
        UserManager.create_apply_payload(apply)
      )

      conn
      |> put_status(:created)
      |> render("show.json", apply: apply)
    end
  end

  def accept_apply(%{assigns: %{user: user}} = conn, params) do
    apply = UserManager.get_apply(params["id"])
    IO.inspect(apply)

    with true <- UserManager.check_user(apply, user),
         {:ok, %Apply{} = apply} <-
           UserManager.update_apply(apply, %{accepted: true}),
         {:ok, _member} <- TeamManager.add_member(apply.team_id, apply.user_id) do
      conn
      |> render("show.json", apply: apply)
    end
  end

  def show(conn, %{"id" => id}) do
    invites = UserManager.get_apply!(id)
    render(conn, "show.json", invites: invites)
  end

  def update(conn, %{"id" => id, "invites" => invites_params}) do
    invites = UserManager.get_apply!(id)

    with {:ok, %Apply{} = invites} <-
      UserManager.update_apply(invites, invites_params) do
      render(conn, "show.json", invites: invites)
    end
  end

  def delete(conn, %{"id" => id}) do
    invites = UserManager.get_apply!(id)

    with {:ok, %Apply{}} <- UserManager.delete_apply(invites) do
      send_resp(conn, :no_content, "")
    end
  end
end
