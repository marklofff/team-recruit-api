defmodule ApiWeb.Resolvers.Team do
  alias Api.TeamManager

  def teams(_, _, _) do
    {:ok, TeamManager.list_teams()}
  end

  def login(_, %{input: input}, _) do
    Accounts.find_or_create(input)
  end
end
