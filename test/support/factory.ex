defmodule TeamRecruit.Factory do
  @moduledoc """
  Factories
  """
  use ExMachina.Ecto, repo: TeamRecruit.Repo
  alias TeamRecruit.Accounts.User

  def user_factory do
    %TeamRecruit.Accounts.User{
      nickname: sequence(:name, &"#{Faker.Name.name()} #{&1}"),
      bio: Faker.Lorem.paragraph(),
    }
  end

  def social_account_factory do
    %TeamRecruit.Accounts.SocialAccounts{
      email: Faker.Internet.email(),
      name: Faker.Name.name(),
      avatar: Faker.Avatar.image_url(),
      uid: Faker.UUID.v4(),
      user: build(:user)
    }
  end

  def user_game_factory do
    user = insert(:user)
    game = insert(:game)

    user
    |> TeamRecruit.Repo.preload(:games)
    |> User.changeset(%{})
    |> Ecto.Changeset.put_assoc(:games, [game])
    |> TeamRecruit.Repo.update!
  end

  def game_factory do
    %TeamRecruit.Games.Game{
      short_name: "csgo",
      full_name: "csgo",
      app_id: "1234",
    }
  end

  def team_factory do
    %TeamRecruit.TeamManager.Team{
      language: "",
      name: sequence(:name, &"My Team Name #{&1}"),
      tag: sequence(:tag, &"mtn#{&1}"),
      bio: sequence(:bio, &"mtn#{&1}"),
      nation: sequence(:nation, &"mtn#{&1}"),
      views: 1,
      wanted: true,
      wanted_num: 5,
      user: build(:user)
    }
  end
end
