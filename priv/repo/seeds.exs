# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TeamRecruit.Repo.insert!(%TeamRecruit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TeamRecruit.Repo
alias TeamRecruit.Games.Game

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
]

for game <- games do
  Repo.insert!(
    %Game{
      full_name: game[:full_name],
      short_name: game[:short_name],
      app_id: game[:app_id],
      provider: game[:provider]
    }   
  )
end
