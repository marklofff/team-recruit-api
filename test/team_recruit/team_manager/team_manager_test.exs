defmodule TeamRecruit.TeamManagerTest do
  use TeamRecruit.DataCase

  alias TeamRecruit.TeamManager

  describe "teams" do
    alias TeamRecruit.TeamManager.Team

    @valid_attrs %{language: "some language", name: "some name", nation: "some nation", views: 42, wanted: true, wanted_num: 42}
    @update_attrs %{language: "some updated language", name: "some updated name", nation: "some updated nation", views: 43, wanted: false, wanted_num: 43}
    @invalid_attrs %{language: nil, name: nil, nation: nil, views: nil, wanted: nil, wanted_num: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamManager.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert TeamManager.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert TeamManager.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = TeamManager.create_team(@valid_attrs)
      assert team.language == "some language"
      assert team.name == "some name"
      assert team.nation == "some nation"
      assert team.views == 42
      assert team.wanted == true
      assert team.wanted_num == 42
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamManager.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = TeamManager.update_team(team, @update_attrs)
      assert team.language == "some updated language"
      assert team.name == "some updated name"
      assert team.nation == "some updated nation"
      assert team.views == 43
      assert team.wanted == false
      assert team.wanted_num == 43
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamManager.update_team(team, @invalid_attrs)
      assert team == TeamManager.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = TeamManager.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> TeamManager.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = TeamManager.change_team(team)
    end
  end
end
