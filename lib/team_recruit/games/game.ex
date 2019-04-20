defmodule TeamRecruit.Games.Game do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias TeamRecruit.TeamManager.Team
  alias TeamRecruit.Utils

  schema "games" do
    field :app_id, :string
    field :full_name, :string
    field :short_name, :string
    field :provider, :string
    field :icon, TeamRecruit.GameIcon.Type

    many_to_many :teams, Team, join_through: "teams_games"
    many_to_many :users, Team, join_through: "users_games"

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:full_name, :short_name, :app_id, :provider])
    |> validate_required([:full_name, :short_name, :app_id, :provider])
    |> Utils.check_uuid
    |> cast_attachments(attrs, [:avatar])
  end
end
