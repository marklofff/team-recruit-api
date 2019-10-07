defmodule TeamRecruit.TeamTest do
  use TeamRecruit.DataCase

  alias TeamRecruit.Team

  describe "teams" do
    alias TeamRecruit.Team.Teams

    @valid_attrs %{bio: "some bio", langueage: "some langueage", name: "some name", nation: "some nation", tag: "some tag"}
    @update_attrs %{bio: "some updated bio", langueage: "some updated langueage", name: "some updated name", nation: "some updated nation", tag: "some updated tag"}
    @invalid_attrs %{bio: nil, langueage: nil, name: nil, nation: nil, tag: nil}

    def teams_fixture(attrs \\ %{}) do
      {:ok, teams} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Team.create_teams()

      teams
    end

    test "list_teams/0 returns all teams" do
      teams = teams_fixture()
      assert Team.list_teams() == [teams]
    end

    test "get_teams!/1 returns the teams with given id" do
      teams = teams_fixture()
      assert Team.get_teams!(teams.id) == teams
    end

    test "create_teams/1 with valid data creates a teams" do
      assert {:ok, %Teams{} = teams} = Team.create_teams(@valid_attrs)
      assert teams.bio == "some bio"
      assert teams.langueage == "some langueage"
      assert teams.name == "some name"
      assert teams.nation == "some nation"
      assert teams.tag == "some tag"
    end

    test "create_teams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_teams(@invalid_attrs)
    end

    test "update_teams/2 with valid data updates the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{} = teams} = Team.update_teams(teams, @update_attrs)
      assert teams.bio == "some updated bio"
      assert teams.langueage == "some updated langueage"
      assert teams.name == "some updated name"
      assert teams.nation == "some updated nation"
      assert teams.tag == "some updated tag"
    end

    test "update_teams/2 with invalid data returns error changeset" do
      teams = teams_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_teams(teams, @invalid_attrs)
      assert teams == Team.get_teams!(teams.id)
    end

    test "delete_teams/1 deletes the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{}} = Team.delete_teams(teams)
      assert_raise Ecto.NoResultsError, fn -> Team.get_teams!(teams.id) end
    end

    test "change_teams/1 returns a teams changeset" do
      teams = teams_fixture()
      assert %Ecto.Changeset{} = Team.change_teams(teams)
    end
  end
end
