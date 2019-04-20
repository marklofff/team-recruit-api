defmodule TeamRecruitWeb.TeamController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.TeamManager
  alias TeamRecruit.TeamManager.Team

  action_fallback TeamRecruitWeb.FallbackController

  def index(conn, _params) do
    teams = TeamManager.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def get_my_teams(%{assigns: %{user: user}} = conn, _params) do
    teams = TeamManager.get_my_teams(user.id)
    render(conn, "index.json", teams: teams)
  end

  def create(%{assigns: %{user: user}} = conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- TeamManager.create_team(user.id, team_params) do
      conn
      |> put_status(:created)
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"tag" => tag}) do
    team = TeamManager.get_team_by_tag!(tag)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = TeamManager.get_team!(id)

    with {:ok, %Team{} = team} <- TeamManager.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = TeamManager.get_team!(id)

    with {:ok, %Team{}} <- TeamManager.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_new_game(%{assigns: %{user: user}} = conn, %{"team_id" => team_id, "game_id" => game_id}) do
    with {:ok, _team} <- TeamManager.add_game(user, team_id, game_id) do
      json(conn, %{success: true})
    end
  end
end
