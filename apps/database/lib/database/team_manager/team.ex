defmodule Database.TeamManager.Team do
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
    field :views, :integer
    field :wanted, :boolean, default: false
    field :wanted_num, :integer

    # avatar
    field :avatar, ImageUploader.TeamAvatar.Type
    field :uuid, :string

    # leader
    belongs_to :user, Database.Accounts.User

    # have many games
    many_to_many :games, Database.Games.Game, join_through: "teams_games"

    # has many
    has_many :members, Database.TeamManager.Member
    has_many :awards, Database.TeamManager.Awards

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :tag, :bio, :wanted_num, :views, :wanted, :nation, :language])
    |> validate_required([:name, :tag])
    |> unique_constraint(:tag)
    |> Database.Utils.check_uuid()
    |> cast_attachments(attrs, [:avatar], allow_paths: true)
  end
end
