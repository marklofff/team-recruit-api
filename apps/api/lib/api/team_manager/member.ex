defmodule Api.TeamManager.Member do
  @moduledoc """
  Member
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    belongs_to :user, Api.Accounts.User
    belongs_to :team, Api.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint(:user_id, name: :members_user_id_team_id_index) # check if the user already exists
  end
end
