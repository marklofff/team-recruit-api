defmodule TeamRecruit.TeamManager.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    belongs_to :user, TeamRecruit.Accounts.User
    belongs_to :team, TeamRecruit.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end
end
