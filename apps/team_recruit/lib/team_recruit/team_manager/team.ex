defmodule TeamRecruit.TeamManager.Team do
  @moduledoc """
  Team
  """
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :language, :string
    field :name, :string
    field :tag, :string
    field :bio, :string
    field :nation, :string

    # avatar
    field :avatar, TeamRecruit.TeamAvatar.Type
    field :background_image, TeamRecruit.TeamBackgroundImage.Type
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
    |> cast(attrs, [:name, :tag, :bio, :nation, :language])
    |> validate_required([:name, :tag])
    |> unique_constraint(:tag)
    |> TeamRecruit.Utils.check_uuid()
    |> cast_attachments(attrs, [:avatar], allow_paths: true)
    |> cast_attachments(attrs, [:background_image], allow_paths: true)
  end
end
