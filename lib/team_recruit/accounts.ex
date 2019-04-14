defmodule TeamRecruit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TeamRecruit.Repo

  alias TeamRecruit.Accounts.User

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

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
    |> Repo.preload([:teams, :games])
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_by_userId!(userId) do
    query = from u in User,
      where: u.userId == ^userId

    Repo.one(query)
    |> Repo.preload([{:teams, [:user, :games, :awards]}, :games])
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
    {:ok, %User{} = user} = %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

    {:ok, Repo.preload(user, [:steam_account, :teams])}
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    {:ok, result} =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    {:ok, Repo.preload(result, [{:teams, [:user, :games, :awards]}, :games])}
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
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

  defp verify_pass(nil, _), do: {:error, "Incorrect email or password."}
  defp verify_pass(user, plain_text_password) do
    case Argon2.verify_pass(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password."}
    end
  end
end
