defmodule Api.Notifications do
  @moduledoc """
  The Notifications context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Notifications.Invitation

  @doc """
  Returns the list of Invitation.

  ## Examples

      iex> list_Invitation()
      [%invitation{}, ...]

  """
  def list_invitation(user_id) do
    query = 
      from i in Invitation,
      where: i.user_id == ^user_id,
      preload: [[team: :user], :user]

    Repo.all(query)
  end

  def create_invitation_payload(invitation) do
    %{
      type: "invitation:new",
      from: %{
        team: %{name: invitation.team.name, user: invitation.team.user.name},
      }
    }
  end

  def list_invitation(_) do
    Repo.all(Invitation)
  end

  @doc """
  Gets a single Invitation.

  Raises `Ecto.NoResultsError` if the invitation does not exist.

  ## Examples

      iex> get_invitation!(123)
      %invitation{}

      iex> get_invitation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invitation!(id), do: Repo.get!(Invitation, id)

  def check_user(%Invitation{} = invitation, %Api.Accounts.User{} = user) do
    if invitation.user_id == user.id do
      IO.puts "is user"
      true
    else
      {:error, "No permission."}
    end
  end

  @doc """
  Creates a invitation.

  ## Examples

      iex> create_invitation(%{field: value})
      {:ok, %Invitation{}}

      iex> create_invitation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invitation(%{"user" => user} = attrs \\ %{}) do
    team = Api.TeamManager.get_team!(attrs["team_id"])
    IO.inspect user.id

    if user.id == team.user_id do
      %Invitation{team_id: attrs["team_id"], user_id: attrs["user_id"]}
      |> Invitation.changeset(attrs)
      |> Repo.insert()
    else
      {:error, "You don't have permission."}
    end
  end

  @doc """
  Updates a invitation.

  ## Examples

      iex> update_invitation(invites, %{field: new_value})
      {:ok, %Invitation{}}

      iex> update_invitation(invites, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invitation(%Invitation{} = invitation, attrs) do
    invitation
    |> Invitation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invitation.

  ## Examples

      iex> delete_invitation(invites)
      {:ok, %Invitation{}}

      iex> delete_invitation(invites)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invitation(%Invitation{} = invitation) do
    Repo.delete(invitation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invitation changes.

  ## Examples

      iex> change_invitation(invites)
      %Ecto.Changeset{source: %invitation{}}

  """
  def change_invitation(%Invitation{} = invitation) do
    Invitation.changeset(invitation, %{})
  end
end
