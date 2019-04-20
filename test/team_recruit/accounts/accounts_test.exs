defmodule TeamRecruit.AccountsTest do
  use TeamRecruit.DataCase

  alias TeamRecruit.Accounts

  describe "users" do
    alias TeamRecruit.Accounts.User

    @valid_attrs %{email: "some email", name: "some name", password: "some password", userId: "some userId"}
    @update_attrs %{email: "some updated email", name: "some updated name", password: "some updated password", userId: "some updated userId"}
    @invalid_attrs %{email: nil, name: nil, password: nil, userId: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.userId == "some userId"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.userId == "some updated userId"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "steam" do
    alias TeamRecruit.Accounts.Steam

    @valid_attrs %{avatar: "some avatar", avatarfull: "some avatarfull", avatarmedium: "some avatarmedium", personaname: "some personaname", profileurl: "some profileurl", realname: "some realname", steamid: "some steamid"}
    @update_attrs %{avatar: "some updated avatar", avatarfull: "some updated avatarfull", avatarmedium: "some updated avatarmedium", personaname: "some updated personaname", profileurl: "some updated profileurl", realname: "some updated realname", steamid: "some updated steamid"}
    @invalid_attrs %{avatar: nil, avatarfull: nil, avatarmedium: nil, personaname: nil, profileurl: nil, realname: nil, steamid: nil}

    def steam_fixture(attrs \\ %{}) do
      {:ok, steam} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_steam()

      steam
    end

    test "list_steam/0 returns all steam" do
      steam = steam_fixture()
      assert Accounts.list_steam() == [steam]
    end

    test "get_steam!/1 returns the steam with given id" do
      steam = steam_fixture()
      assert Accounts.get_steam!(steam.id) == steam
    end

    test "create_steam/1 with valid data creates a steam" do
      assert {:ok, %Steam{} = steam} = Accounts.create_steam(@valid_attrs)
      assert steam.avatar == "some avatar"
      assert steam.avatarfull == "some avatarfull"
      assert steam.avatarmedium == "some avatarmedium"
      assert steam.personaname == "some personaname"
      assert steam.profileurl == "some profileurl"
      assert steam.realname == "some realname"
      assert steam.steamid == "some steamid"
    end

    test "create_steam/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_steam(@invalid_attrs)
    end

    test "update_steam/2 with valid data updates the steam" do
      steam = steam_fixture()
      assert {:ok, %Steam{} = steam} = Accounts.update_steam(steam, @update_attrs)
      assert steam.avatar == "some updated avatar"
      assert steam.avatarfull == "some updated avatarfull"
      assert steam.avatarmedium == "some updated avatarmedium"
      assert steam.personaname == "some updated personaname"
      assert steam.profileurl == "some updated profileurl"
      assert steam.realname == "some updated realname"
      assert steam.steamid == "some updated steamid"
    end

    test "update_steam/2 with invalid data returns error changeset" do
      steam = steam_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_steam(steam, @invalid_attrs)
      assert steam == Accounts.get_steam!(steam.id)
    end

    test "delete_steam/1 deletes the steam" do
      steam = steam_fixture()
      assert {:ok, %Steam{}} = Accounts.delete_steam(steam)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_steam!(steam.id) end
    end

    test "change_steam/1 returns a steam changeset" do
      steam = steam_fixture()
      assert %Ecto.Changeset{} = Accounts.change_steam(steam)
    end
  end

  describe "discord" do
    alias TeamRecruit.Accounts.Discord

    @valid_attrs %{avatar: "some avatar", discriminator: "some discriminator", userid: "some userid", username: "some username"}
    @update_attrs %{avatar: "some updated avatar", discriminator: "some updated discriminator", userid: "some updated userid", username: "some updated username"}
    @invalid_attrs %{avatar: nil, discriminator: nil, userid: nil, username: nil}

    def discord_fixture(attrs \\ %{}) do
      {:ok, discord} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_discord()

      discord
    end

    test "list_discord/0 returns all discord" do
      discord = discord_fixture()
      assert Accounts.list_discord() == [discord]
    end

    test "get_discord!/1 returns the discord with given id" do
      discord = discord_fixture()
      assert Accounts.get_discord!(discord.id) == discord
    end

    test "create_discord/1 with valid data creates a discord" do
      assert {:ok, %Discord{} = discord} = Accounts.create_discord(@valid_attrs)
      assert discord.avatar == "some avatar"
      assert discord.discriminator == "some discriminator"
      assert discord.userid == "some userid"
      assert discord.username == "some username"
    end

    test "create_discord/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_discord(@invalid_attrs)
    end

    test "update_discord/2 with valid data updates the discord" do
      discord = discord_fixture()
      assert {:ok, %Discord{} = discord} = Accounts.update_discord(discord, @update_attrs)
      assert discord.avatar == "some updated avatar"
      assert discord.discriminator == "some updated discriminator"
      assert discord.userid == "some updated userid"
      assert discord.username == "some updated username"
    end

    test "update_discord/2 with invalid data returns error changeset" do
      discord = discord_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_discord(discord, @invalid_attrs)
      assert discord == Accounts.get_discord!(discord.id)
    end

    test "delete_discord/1 deletes the discord" do
      discord = discord_fixture()
      assert {:ok, %Discord{}} = Accounts.delete_discord(discord)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_discord!(discord.id) end
    end

    test "change_discord/1 returns a discord changeset" do
      discord = discord_fixture()
      assert %Ecto.Changeset{} = Accounts.change_discord(discord)
    end
  end

  describe "user_accounts" do
    alias TeamRecruit.Accounts.UserAccount

    @valid_attrs %{bio: "some bio"}
    @update_attrs %{bio: "some updated bio"}
    @invalid_attrs %{bio: nil}

    def user_account_fixture(attrs \\ %{}) do
      {:ok, user_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_account()

      user_account
    end

    test "list_user_accounts/0 returns all user_accounts" do
      user_account = user_account_fixture()
      assert Accounts.list_user_accounts() == [user_account]
    end

    test "get_user_account!/1 returns the user_account with given id" do
      user_account = user_account_fixture()
      assert Accounts.get_user_account!(user_account.id) == user_account
    end

    test "create_user_account/1 with valid data creates a user_account" do
      assert {:ok, %UserAccount{} = user_account} = Accounts.create_user_account(@valid_attrs)
      assert user_account.bio == "some bio"
    end

    test "create_user_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_account(@invalid_attrs)
    end

    test "update_user_account/2 with valid data updates the user_account" do
      user_account = user_account_fixture()
      assert {:ok, %UserAccount{} = user_account} = Accounts.update_user_account(user_account, @update_attrs)
      assert user_account.bio == "some updated bio"
    end

    test "update_user_account/2 with invalid data returns error changeset" do
      user_account = user_account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_account(user_account, @invalid_attrs)
      assert user_account == Accounts.get_user_account!(user_account.id)
    end

    test "delete_user_account/1 deletes the user_account" do
      user_account = user_account_fixture()
      assert {:ok, %UserAccount{}} = Accounts.delete_user_account(user_account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_account!(user_account.id) end
    end

    test "change_user_account/1 returns a user_account changeset" do
      user_account = user_account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_account(user_account)
    end
  end

  describe "link_accounts" do
    alias TeamRecruit.Accounts.LinkAccounts

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def link_accounts_fixture(attrs \\ %{}) do
      {:ok, link_accounts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_link_accounts()

      link_accounts
    end

    test "list_link_accounts/0 returns all link_accounts" do
      link_accounts = link_accounts_fixture()
      assert Accounts.list_link_accounts() == [link_accounts]
    end

    test "get_link_accounts!/1 returns the link_accounts with given id" do
      link_accounts = link_accounts_fixture()
      assert Accounts.get_link_accounts!(link_accounts.id) == link_accounts
    end

    test "create_link_accounts/1 with valid data creates a link_accounts" do
      assert {:ok, %LinkAccounts{} = link_accounts} = Accounts.create_link_accounts(@valid_attrs)
    end

    test "create_link_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_link_accounts(@invalid_attrs)
    end

    test "update_link_accounts/2 with valid data updates the link_accounts" do
      link_accounts = link_accounts_fixture()
      assert {:ok, %LinkAccounts{} = link_accounts} = Accounts.update_link_accounts(link_accounts, @update_attrs)
    end

    test "update_link_accounts/2 with invalid data returns error changeset" do
      link_accounts = link_accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_link_accounts(link_accounts, @invalid_attrs)
      assert link_accounts == Accounts.get_link_accounts!(link_accounts.id)
    end

    test "delete_link_accounts/1 deletes the link_accounts" do
      link_accounts = link_accounts_fixture()
      assert {:ok, %LinkAccounts{}} = Accounts.delete_link_accounts(link_accounts)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_link_accounts!(link_accounts.id) end
    end

    test "change_link_accounts/1 returns a link_accounts changeset" do
      link_accounts = link_accounts_fixture()
      assert %Ecto.Changeset{} = Accounts.change_link_accounts(link_accounts)
    end
  end

  describe "google_accounts" do
    alias TeamRecruit.Accounts.GoogleAccount

    @valid_attrs %{email: "some email", name: "some name", picture: "some picture"}
    @update_attrs %{email: "some updated email", name: "some updated name", picture: "some updated picture"}
    @invalid_attrs %{email: nil, name: nil, picture: nil}

    def google_account_fixture(attrs \\ %{}) do
      {:ok, google_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_google_account()

      google_account
    end

    test "list_google_accounts/0 returns all google_accounts" do
      google_account = google_account_fixture()
      assert Accounts.list_google_accounts() == [google_account]
    end

    test "get_google_account!/1 returns the google_account with given id" do
      google_account = google_account_fixture()
      assert Accounts.get_google_account!(google_account.id) == google_account
    end

    test "create_google_account/1 with valid data creates a google_account" do
      assert {:ok, %GoogleAccount{} = google_account} = Accounts.create_google_account(@valid_attrs)
      assert google_account.email == "some email"
      assert google_account.name == "some name"
      assert google_account.picture == "some picture"
    end

    test "create_google_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_google_account(@invalid_attrs)
    end

    test "update_google_account/2 with valid data updates the google_account" do
      google_account = google_account_fixture()
      assert {:ok, %GoogleAccount{} = google_account} = Accounts.update_google_account(google_account, @update_attrs)
      assert google_account.email == "some updated email"
      assert google_account.name == "some updated name"
      assert google_account.picture == "some updated picture"
    end

    test "update_google_account/2 with invalid data returns error changeset" do
      google_account = google_account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_google_account(google_account, @invalid_attrs)
      assert google_account == Accounts.get_google_account!(google_account.id)
    end

    test "delete_google_account/1 deletes the google_account" do
      google_account = google_account_fixture()
      assert {:ok, %GoogleAccount{}} = Accounts.delete_google_account(google_account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_google_account!(google_account.id) end
    end

    test "change_google_account/1 returns a google_account changeset" do
      google_account = google_account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_google_account(google_account)
    end
  end
end
