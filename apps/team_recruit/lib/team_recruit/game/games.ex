defmodule TeamRecruit.Game.Games do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :app_id, :string
    field :full_name, :string
    field :icon, :string
    field :provider, :string
    field :short_name, :string

    timestamps()
  end

  @doc false
  def changeset(games, attrs) do
    games
    |> cast(attrs, [:full_name, :short_name, :app_id, :provider, :icon])
    |> validate_required([:full_name, :short_name, :app_id, :provider, :icon])
  end
end
