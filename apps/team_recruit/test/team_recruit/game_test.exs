defmodule TeamRecruit.GameTest do
  use TeamRecruit.DataCase

  alias TeamRecruit.Game

  describe "games" do
    alias TeamRecruit.Game.Games

    @valid_attrs %{app_id: "some app_id", full_name: "some full_name", icon: "some icon", provider: "some provider", short_name: "some short_name"}
    @update_attrs %{app_id: "some updated app_id", full_name: "some updated full_name", icon: "some updated icon", provider: "some updated provider", short_name: "some updated short_name"}
    @invalid_attrs %{app_id: nil, full_name: nil, icon: nil, provider: nil, short_name: nil}

    def games_fixture(attrs \\ %{}) do
      {:ok, games} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_games()

      games
    end

    test "list_games/0 returns all games" do
      games = games_fixture()
      assert Game.list_games() == [games]
    end

    test "get_games!/1 returns the games with given id" do
      games = games_fixture()
      assert Game.get_games!(games.id) == games
    end

    test "create_games/1 with valid data creates a games" do
      assert {:ok, %Games{} = games} = Game.create_games(@valid_attrs)
      assert games.app_id == "some app_id"
      assert games.full_name == "some full_name"
      assert games.icon == "some icon"
      assert games.provider == "some provider"
      assert games.short_name == "some short_name"
    end

    test "create_games/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_games(@invalid_attrs)
    end

    test "update_games/2 with valid data updates the games" do
      games = games_fixture()
      assert {:ok, %Games{} = games} = Game.update_games(games, @update_attrs)
      assert games.app_id == "some updated app_id"
      assert games.full_name == "some updated full_name"
      assert games.icon == "some updated icon"
      assert games.provider == "some updated provider"
      assert games.short_name == "some updated short_name"
    end

    test "update_games/2 with invalid data returns error changeset" do
      games = games_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_games(games, @invalid_attrs)
      assert games == Game.get_games!(games.id)
    end

    test "delete_games/1 deletes the games" do
      games = games_fixture()
      assert {:ok, %Games{}} = Game.delete_games(games)
      assert_raise Ecto.NoResultsError, fn -> Game.get_games!(games.id) end
    end

    test "change_games/1 returns a games changeset" do
      games = games_fixture()
      assert %Ecto.Changeset{} = Game.change_games(games)
    end
  end
end
