defmodule TeamRecruit.Notifications.Invitation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invitations" do
    field :accepted, :boolean, default: false
    field :message, :string
    belongs_to :user, TeamRecruit.Accounts.User
    belongs_to :team, TeamRecruit.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [:message, :accepted])
    |> validate_required([:message, :accepted])
  end
end
