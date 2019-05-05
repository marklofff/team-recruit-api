# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%TeamRecruit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Api.Repo
alias Api.Games.Game
alias Api.Accounts
alias Api.Accounts.User
alias Api.TeamManager.Team

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
      Api.TeamManager.add_member(team.id, x)
    end
  end

  Api.TeamManager.add_game(team.id, 1)
  Api.TeamManager.add_game(team.id, 2)
  Api.TeamManager.add_game(team.id, 3)
end

{:ok, user} =
  Api.Accounts.get_user!(10)
  |> User.update_changeset(%{email: "asdfasdf@gmail.com", password: "asdfasdfasdf"})
  |> Api.Repo.update()
