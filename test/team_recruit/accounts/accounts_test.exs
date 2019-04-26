defmodule TeamRecruit.AccountsTest do
  import TeamRecruit.Factory
  use TeamRecruit.DataCase

  alias TeamRecruit.Accounts
  alias TeamRecruit.Accounts.User

  @valid_attrs %{nickname: "nickname", 
    bio: "some bio",
    userId: "some userId"}


  defp with_social_accounts(user) do
    insert(:social_account, user: user)
    user
  end

  describe "ger_user!/1" do
    it "returns a valid user" do
      user =
        insert(:user)
        |> with_social_accounts()
        |> Repo.preload([:social_accounts, :teams, :games])

      assert Accounts.get_user!(user.id) == user
    end
  end

  describe "create_user/1" do
    it "creates a valid user" do
      {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)

      assert user.nickname == @valid_attrs.nickname
    end
  end

  describe "update_user/2" do
    it "updates a valid user" do
      user = insert(:user)
      {:ok, updated_user} = Accounts.update_user(user, %{nickname: "my_new_nick_name"})

      assert updated_user.nickname == "my_new_nick_name"
    end
  end

  describe "add_social_account/2" do
    it "should add a new social_account to an existing account" do
      user =
        insert(:user)
        |> with_social_accounts()

      data =
        Path.join(File.cwd!, "test/team_recruit/accounts/api_response.json")
        |> File.read!
        |> Jason.decode!

      updated_user = Accounts.add_social_account(user, "")
    end
  end

  describe "find_or_create/1" do
    it "Creates a user within a social account connected." do
      # load steam openid response data example
      data =
        Path.join(File.cwd!, "test/team_recruit/accounts/api_response.json")
        |> File.read!
        |> Jason.decode!

      # conver data into database table format
      profile = TeamRecruit.Representer.to_map(data["_json"])

      {:ok, %User{} = user} = Accounts.find_or_create(profile)

      assert user_object["uid"] == data["_json"]["id"]
      assert Map.get(user, :provider) == provider
    end
  end

  describe "find_or_create/2" do
    it "should create and return a user with valid provider" do
      # load steam openid response data example
      data =
        Path.join(File.cwd!, "test/team_recruit/accounts/api_response.json")
        |> File.read!
        |> Jason.decode!

      # convert String type provider to atom
      provider = String.to_atom(data["provider"])

      # conver data into database table format
      user_object = TeamRecruit.Representer.to_map(:steam, data["_json"])

      {:ok, %User{} = user} = Accounts.create_account(user_object, provider)

      assert user_object["uid"] == data["_json"]["id"]
      assert Map.get(user, :provider) == provider
    end
  end

  test "list_users/0 returns all users" do
    user = insert(:user)
    assert Accounts.list_users() == [user]
  end

  test "get_user!/1 returns all users" do
    user = insert(:user)
    assert Accounts.list_users() == [user]
  end
end
