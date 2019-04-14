defmodule TeamRecruit.Accounts.SteamAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "steam_accounts" do
    field :avatar, :string
    field :avatarfull, :string
    field :avatarmedium, :string
    field :communityvisibilitystate, :integer
    field :personaname, :string
    field :profilestate, :integer
    field :profileurl, :string
    field :steamid, :string

    belongs_to :user, TeamRecruit.Accounts.User
    has_many :teams, TeamRecruit.TeamManager.Team
    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:steamid, :personaname, :profileurl, :avatar, :avatarmedium, :avatarfull, :communityvisibilitystate, :profilestate])
    |> validate_required([:steamid, :personaname, :profileurl, :avatar, :avatarmedium, :avatarfull, :communityvisibilitystate, :profilestate])
    |> unique_constraint(:user_id)
  end
end
