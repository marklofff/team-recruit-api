defmodule TeamRecruit.UserManager do
  @moduledoc """
  The User Manager context.
  """

  import Ecto.Query, warn: false
  alias TeamRecruit.Repo

  alias TeamRecruit.Notifications.Apply

  @doc """
  Returns the list of Apply.

  ## Examples

      iex> list_apply()
      [%apply{}, ...]

  """
  def list_apply(user_id) when is_binary(user_id) do
    query =
      from i in Apply,
        where: i.user_id == ^user_id,
        preload: [[team: :user], :user]

    Repo.all(query)
  end

  def list_apply(_) do
    Repo.all(Apply)
  end

  def create_apply_payload(apply) do
    %{
      type: "apply:new",
      from: %{
        team: %{name: apply.team.name, user: apply.team.user.name}
      }
    }
  end

  @doc """
  Gets a single Apply.

  Raises `Ecto.NoResultsError` if the apply does not exist.

  ## Examples

      iex> get_apply!(123)
      %apply{}

      iex> get_apply!(456)
      ** (Ecto.NoResultsError)

  """
  def get_apply!(id), do: Repo.get!(Apply, id)

  def check_user(%Apply{} = apply, %TeamRecruit.Accounts.User{} = user) do
    if apply.user_id == user.id do
      IO.puts("is user")
      true
    else
      {:error, "No permission."}
    end
  end

  @doc """
  Creates a apply.

  ## Examples

      iex> create_apply(%{field: value})
      {:ok, %Apply{}}

      iex> create_apply(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_apply(%{"user" => user} = attrs \\ %{}) do
    team = TeamRecruit.TeamManager.get_team!(attrs["team_id"])
    IO.inspect(user.id)

    if user.id == team.user_id do
      %Apply{team_id: attrs["team_id"], user_id: attrs["user_id"]}
      |> Apply.changeset(attrs)
      |> Repo.insert()
    else
      {:error, "You don't have permission."}
    end
  end

  @doc """
  Updates a apply.

  ## Examples

      iex> update_apply(invites, %{field: new_value})
      {:ok, %Apply{}}

      iex> update_apply(invites, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_apply(%Apply{} = apply, attrs) do
    apply
    |> Apply.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a apply.

  ## Examples

      iex> delete_apply(invites)
      {:ok, %Apply{}}

      iex> delete_apply(invites)
      {:error, %Ecto.Changeset{}}

  """
  def delete_apply(%Apply{} = apply) do
    Repo.delete(apply)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking apply changes.

  ## Examples

      iex> change_apply(invites)
      %Ecto.Changeset{source: %apply{}}

  """
  def change_apply(%Apply{} = apply) do
    Apply.changeset(apply, %{})
  end
end
