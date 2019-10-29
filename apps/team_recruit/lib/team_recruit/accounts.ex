defmodule TeamRecruit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TeamRecruit.Repo
  alias TeamRecruit.Accounts.{User, SocialAccounts}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user!(123)
      %User{...}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.one!(
      from u in User,
      where: u.id == ^id,
      preload: [:social_accounts, :teams, :games]
    )
  end

  @doc """
  Gets a single user by email.

  ## Examples

      iex> get_user_by_email!(123)
      %User{...}

      iex> get_user_by_email!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_by_email!(email) do
    Repo.one!(
      from u in User,
      where: u.email == ^email,
      preload: [:social_accounts, :teams, :games]
    )
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new social account for a user.

  ## Examples

      iex> add_social_account(user, %{...fields})
      {:ok, %SocialAccounts{}}

      iex> add_social_account(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def add_social_account(%User{} = user, social_account) do
    %SocialAccounts{
      email: social_account.email,
      name: social_account.name,
      avatar: social_account.avatar,
      provider: social_account.provider,
      uid: social_account.uid,
      user_id: user.id
    } |> Repo.insert!()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
    Creates a user within a social account connected.
    Connect an social account to a existing user
  """
  def find_or_create(
    %User{} = current_user,
    %{provider: provider, uid: uid} = profile
  ) do
    # if user does not have this provider
    case get_user_by_profile(provider, uid) do
      %User{} = user ->
        {:ok, Repo.preload(user, [:social_accounts])}
      nil ->
        add_social_account(current_user, profile)
        {:ok, current_user}
    end
  end

  def find_or_create(%{provider: provider, uid: uid} = profile) do
    with %User{} = user <- get_user_by_profile(provider, uid) do
      {:ok, Repo.preload(user, [:social_accounts, :teams])}
    else
      nil ->
        attrs = %{
          email: profile.email,
          avatar: profile.avatar,
          provider: profile.provider,
          nickname: profile.name |> String.split() |> Enum.at(-1),
          social_accounts: [profile]
        }

        create_user(attrs)
    end
  end

  def get_user_by_profile(provider, uid) do
    User
    |> join(:left, [u], s in assoc(u, :social_accounts), on: s.uid == ^uid)
    |> where([u, s], s.provider == ^provider)
    |> Repo.one()
  end

  def get_user_by_email(provider, email) do
    User
    |> where([u], u.provider == ^provider)
    |> where([u], u.email == ^email)
    |> preload(:social_accounts)
    |> Repo.one()
  end

  def get_user_by_uuid!(uuid) do
    User
    |> where([u], u.uuid == ^uuid)
    |> Repo.one()
  end

  defp get_by_email(email) when is_binary(email) do
    query =
      from u in User,
        where: u.email == ^email,
        preload: [:steam_account]

    case Repo.one(query) do
      nil -> {:error, "Login error."}
      user -> {:ok, user}
    end
  end

  def sign_in(user_params) do
    with {:ok, user} <- get_by_email(user_params["email"]) do
      verify_pass(user, user_params["password"])
    end
  end

  defp verify_pass(nil, _), do: {:error, "Incorrect email or password."}
  defp verify_pass(user, plain_text_password) do
    case Argon2.verify_pass(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password."}
    end
  end
end
