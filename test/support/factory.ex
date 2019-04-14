defmodule TeamRecruit.Factory do
  use ExMachina.Ecto, repo: TeamRecruit.Repo

  def user_factory do
    %TeamRecruit.Accounts.User{
      name: sequence(:name, &"Test テスト User #{&1}"),
      userId: sequence(:userId, &"user#{&1}"),
      email: sequence(:email, &"user#{&1}@test.com"),
      password: "password",
      password_confirmation: "password",
      bio: sequence(:bio, &"Tester Number #{&1}"),
    }
  end

  def game_factory do
    %TeamRecruit.Games.Game{
      short_name: "csgo",
      full_name: "csgo",
      app_id: "1234"
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
