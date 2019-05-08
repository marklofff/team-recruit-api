defmodule ApiWeb.Resolvers.User do
  alias Api.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def login(_, %{input: input}, _) do
    Accounts.find_or_create(input)
  end
end
