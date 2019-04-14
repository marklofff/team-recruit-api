defmodule TeamRecruit.LinkManager do
  @moduledoc """
  The LinkManager.
  """

  import Ecto.Query, warn: false
  alias TeamRecruit.Repo

  alias TeamRecruit.Accounts.{User, SteamAccount}

  @doc """
  Creates a user.

  ## Examples

      iex> create_steam_account(%{field: value})
      {:ok, %SteamAccount{}}

      iex> create_steam_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_steam_account(user, attrs \\ %{}) do
    %SteamAccount{user_id: user.id}
    |> SteamAccount.changeset(attrs)
    |> Repo.insert()
  end

  def get_steam_account(user_id) do
    Repo.get_by(SteamAccount, user_id: user_id)
  end
end
