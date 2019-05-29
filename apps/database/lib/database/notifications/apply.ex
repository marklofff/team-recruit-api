defmodule Database.Notifications.Apply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applies" do
    field :accepted, :boolean, default: false
    field :message, :string
    belongs_to :user, Database.Accounts.User
    belongs_to :team, Database.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [:message, :accepted])
    |> validate_required([:message, :accepted])
  end
end
