defmodule TeamRecruitWeb.TeamControllerTest do
  use TeamRecruitWeb.ConnCase
  import TeamRecruit.Factory

  alias TeamRecruit.TeamManager.Team

  defp valid_team(_context) do
    team = insert(:team)
    [team: team]
  end

  @create_attrs %{
    language: "some language",
    name: "some name",
    tag: "some tag",
    nation: "some nation",
    views: 42,
    wanted: true,
    wanted_num: 42
  }
  @update_attrs %{
    language: "some updated language",
    name: "some updated name",
    tag: "some updated name",
    nation: "some updated nation",
    views: 43,
    wanted: false,
    wanted_num: 43
  }
  @invalid_attrs %{language: nil, name: nil, nation: nil, views: nil, wanted: nil, wanted_num: nil, tag: nil}

  setup %{conn: conn} do
    user = insert(:user)

    {:ok, token, _claims} = TeamRecruit.Guardian.encode_and_sign(user)

    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all teams", %{conn: conn} do
      conn = get(conn, Routes.team_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create team" do
    test "renders team when data is valid", %{conn: conn} do
      conn = post(conn, Routes.team_path(conn, :create), team: @create_attrs)
      assert %{"tag" => tag} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.team_path(conn, :show, tag))

      assert %{
               "id" => id,
               "language" => "some language",
               "name" => "some name",
               "nation" => "some nation",
               "views" => 42,
               "wanted" => true,
               "wanted_num" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.team_path(conn, :create), team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update team" do
    setup [:valid_team]

    test "renders team when data is valid", %{conn: conn, team: %Team{id: id} = _team} do
      conn = put(conn, Routes.team_path(conn, :update, id), team: @update_attrs)
      response = json_response(conn, 200)["data"]
      assert %{"id" => ^id} = response
      %{"tag" => tag} = response

      conn = get(conn, Routes.team_path(conn, :show, tag))

      assert %{
               "id" => id,
               "language" => "some updated language",
               "name" => "some updated name",
               "nation" => "some updated nation",
               "views" => 43,
               "wanted" => false,
               "wanted_num" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, team: team} do
      conn = put(conn, Routes.team_path(conn, :update, team), team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete team" do
    setup [:valid_team]

    test "deletes chosen team", %{conn: conn, team: team} do
      conn = delete(conn, Routes.team_path(conn, :delete, team))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.team_path(conn, :show, team))
      end
    end
  end

  describe "add team test" do
    setup [:valid_team]
    test "should add a game and return updated team object", %{conn: conn, team: team} do
      game = insert(:game)

      conn = post(conn, Routes.team_path(conn, :add_new_game), %{
        "team_id" => team.id,
        "game_id" => game.id
      })

      assert response(conn, 200)
    end
  end
end
