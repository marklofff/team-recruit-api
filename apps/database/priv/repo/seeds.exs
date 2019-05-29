# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repo.insert!(%TeamRecruit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Database.Repo
alias Database.Games.Game
alias Database.Accounts
alias Database.Accounts.User
alias Database.TeamManager.Team

games = [
  [
    {:app_id, "730"},
    {:full_name, "Counter-Strike: Global Offensive"},
    {:short_name, "CS: GO"},
    {:provider, "steam"}
  ],
  [
    {:app_id, "578080"},
    {:full_name, "PLAYERUNKNOWN'S BATTLEGROUNDS"},
    {:short_name, "PUBG"},
    {:provider, "steam"}
  ],
  [
    {:app_id, ""},
    {:full_name, "Apex Legends"},
    {:short_name, "APEX"},
    {:provider, "origin"}
  ]
]

for game <- games do
  Repo.insert!(%Game{
    full_name: game[:full_name],
    short_name: game[:short_name],
    app_id: game[:app_id],
    provider: game[:provider]
  })
end

HTTPoison.start()

for x <- 1..50 do
  {:ok, user} = Accounts.create_user(%{nickname: "user#{x}", bio: "Bio #{x}"})

  image = HTTPoison.get!("https://picsum.photos/id/#{x}/200/300")
  File.write!("candidate_pics/#{x}.jpeg", image.body, [:binary])

  new_team = %Team{
    user_id: user.id,
    name: "Team #{x}",
    tag: "tag-#{x}",
    bio: "Team #{x}"
  }

  team =
    Repo.insert!(
      Team.changeset(
        new_team,
        %{"avatar" => Path.expand("candidate_pics/#{x}.jpeg")}
      )
    )

  if x > 5 do
    for x <- 1..5 do
      Database.TeamManager.add_member(team.id, x)
    end
  end

  Database.TeamManager.add_game(team.id, 1)
  Database.TeamManager.add_game(team.id, 2)
  Database.TeamManager.add_game(team.id, 3)
end

{:ok, user} =
  Database.Accounts.get_user!(10)
  |> User.update_changeset(%{email: "asdfasdf@gmail.com", password: "asdfasdfasdf"})
  |> Database.Repo.update()
