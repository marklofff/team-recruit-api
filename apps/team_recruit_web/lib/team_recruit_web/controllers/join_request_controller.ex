defmodule TeamRecruitWeb.JoinRequestController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.TeamManager
  alias TeamRecruit.TeamManager.Team
  alias TeamRecruit.TeamManager.JoinRequest

  action_fallback TeamRecruitWeb.FallbackController

  def list_join_requests(%{assigns: %{user: current_user}} = conn,
    %{"id" => id} = params
  ) do
    team = TeamManager.get_team!(id)

    if TeamManager.is_team_leader?(current_user, team) do
      join_requests_list = TeamManager.list_join_requests(%{team_id: team.id}, params)

      render(conn, "index.json", join_requests: join_requests_list)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{msg: "You don't have permission!"})
    end
  end

  def create(%{assigns: %{user: current_user}} = conn,
    %{"team_id" => team_id} = params
  ) do

    with {:ok, join_request} <- TeamManager.create_join_request(current_user.id, team_id) do
      render(conn, "show.json", join_request: join_request)
    end
  end

  def accept_join_request(%{assigns: %{user: current_user}} = conn, %{"id" => id}) do
    join_request = TeamManager.get_join_request(id)

    if TeamRecruit.is_team_leader?(current_user, join_request.team) do
      with {:ok, _updated_team} <- TeamManager.add_member(join_request) do
        conn
        |> put_status(:created)
        |> json(%{success: true})
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{msg: "You don't have permission!"})
    end
  end

  def cancel_join_request(conn, %{"user_id" => user_id, "team_id" => team_id}) do
    with {:ok, _join_reqest} <- TeamManager.delete_join_request(user_id, team_id) do
      json(conn, %{success: true})
    end
  end

  def deny_join_request(conn, %{"user_id" => user_id, "team_id" => team_id}) do
    with {:ok, _updated_team} <- TeamManager.add_member(user_id, team_id) do
      json(conn, %{success: true})
    end
  end
end
