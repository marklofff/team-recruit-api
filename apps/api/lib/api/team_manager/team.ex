defmodule Api.TeamManager.Team do
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
    field :avatar, Api.TeamAvatar.Type
    field :uuid, :string
    
    # leader
    belongs_to :user, Api.Accounts.User

    # have many games
    many_to_many :games, Api.Games.Game, join_through: "teams_games"

    # has many
    has_many :members, Api.TeamManager.Member
    has_many :awards, Api.TeamManager.Awards

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :tag, :bio, :wanted_num, :views, :wanted, :nation, :language])
    |> validate_required([:name, :tag])
    |> unique_constraint(:tag)
    |> Api.Utils.check_uuid
    |> cast_attachments(attrs, [:avatar], allow_paths: true)
  end
end
