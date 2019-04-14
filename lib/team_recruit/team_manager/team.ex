defmodule TeamRecruit.TeamManager.Team do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :language, :string
    field :name, :string
    field :tag, :string
    field :bio, :string
    field :nation, :string
    field :views, :integer
    field :wanted, :boolean, default: false
    field :wanted_num, :integer

    # avatar
    field :avatar, TeamRecruit.TeamAvatar.Type
    field :uuid, :string
    
    # leader
    belongs_to :user, TeamRecruit.Accounts.User

    # have many games
    many_to_many :games, TeamRecruit.Games.Game, join_through: "teams_games"

    # has many
    has_many :members, TeamRecruit.TeamManager.Member
    has_many :awards, TeamRecruit.TeamManager.Awards

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :tag, :bio, :wanted_num, :views, :wanted, :nation, :language])
    |> validate_required([:name, :tag])
    |> unique_constraint(:tag)
    |> TeamRecruit.Utils.check_uuid
    |> cast_attachments(attrs, [:avatar])
  end
end
