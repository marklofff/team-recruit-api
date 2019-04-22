defmodule TeamRecruit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ueberauth.Auth
  alias TeamRecruit.Repo
  alias TeamRecruit.Accounts.User
  alias TeamRecruit.Accounts.SocialAccounts

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    query =
      from u in User,
      where: u.id == ^id,
      preload: [:social_accounts, :teams, :games]

    Repo.one!(query)
  end

  def create_user(attrs \\ %{}) do
    {:ok, user} =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    user = Repo.preload(user, [:social_accounts, :teams, :games])
    {:ok, user}
  end

  def update_user(%User{} = user, attrs) do
    {:ok, result} =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    {:ok, Repo.preload(result, [{:teams, [:user, :games, :awards]}, :games])}
  end
  def update_user(%User{} = user, attrs) do
    {:ok, result} =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    {:ok, Repo.preload(result, [{:teams, [:user, :games, :awards]}, :games])}
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def sign_in(user_params) do
    with {:ok, user} <- get_by_email(user_params["email"]) do
      verify_pass(user, user_params["password"])
    end
  end

  defp get_by_email(email) when is_binary(email) do
    query = from u in User, 
      where: u.email == ^email,
      preload: [:steam_account]

    case Repo.one(query) do
      nil ->
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

  def find_or_create(%Auth{provider: provider, info: info, uid: uid} = auth) do
    params = %{"provider" => provider, "uid" => uid}
    # find any user that is connected to this thirdpaty account

    with %User{} = user <- get_user_by_provider(params) do
      {:ok, Repo.preload(user, [:social_accounts, :teams])}
    else
      nil ->
        auth
        |> TeamRecruit.Representer.to_map()
        |> create_account(provider)
      user ->
        user
    end
  end

  def find_or_create(%User{} = current_user, %Auth{provider: provider, info: info, uid: uid} = auth) do
    user_object = TeamRecruit.Representer.to_map(auth)
    provider_list = ProviderEnum.__enum_map__()

    provider_exists? =
      User
      |> join(:left, [u], s in assoc(u, :social_accounts), on: s.uid == ^to_string(uid))
      |> where([u, s], s.provider == ^provider_list[provider])
      |> Repo.one()

    user =
      case provider_exists? do # if user does not have this provider
        nil ->
          user_object = Map.put(user_object, :provider, provider)

          current_user
          |> update_user(%{social_accounts: [user_object | current_user.social_accounts]})
        user ->
          user
      end

    {:ok, Repo.preload(user, [:social_accounts])}
  end

  def get_user_by_provider(%{"provider" => provider, "uid" => uid} = params) do
    provider_list = ProviderEnum.__enum_map__()

    User
    |> join(:left, [u], s in assoc(u, :social_accounts), on: s.uid == ^to_string(uid))
    |> where([u, s], s.provider == ^provider_list[provider])
    |> Repo.one()
  end

  def create_account(user_object, provider) do
    user_object = Map.put(user_object, :provider, provider)
    IO.inspect user_object

    nickname =
      user_object.name
      |> String.split
      |> Enum.at(-1)

    create_user(%{nickname: nickname, social_accounts: [user_object]})
  end

  defp verify_pass(nil, _), do: {:error, "Incorrect email or password."}
  defp verify_pass(user, plain_text_password) do
    case Argon2.verify_pass(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password."}
    end
  end
end
