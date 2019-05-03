{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start(trace: true)
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(TeamRecruit.Repo, :manual)
