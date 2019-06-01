defmodule Database.TeamManager.Member do
  @moduledoc """
  Member
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    belongs_to :user, Database.Accounts.User
    belongs_to :team, Database.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
    # check if the user already exists
    |> unique_constraint(:user_id, name: :members_user_id_team_id_index)
  end
end
