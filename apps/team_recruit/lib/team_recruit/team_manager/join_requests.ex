defmodule TeamRecruit.TeamManager.JoinRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "join_requests" do
    belongs_to :user, TeamRecruit.Accounts.User
    belongs_to :team, TeamRecruit.TeamManager.Team

    field :accepted, :boolean
    field :message, :string
    field :denied_reason, :string # owner writes back to the user why he got denied

    timestamps()
  end

  @doc false
  def changeset(join_requests, attrs) do
    join_requests
    |> cast(attrs, [:accepted, :message, :denied_reason, :user_id, :team_id])
    |> validate_required([])
    |> unique_constraint(:user_id)
    |> unique_constraint(:team_id)

  end
end
