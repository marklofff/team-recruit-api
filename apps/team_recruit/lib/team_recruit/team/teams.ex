defmodule TeamRecruit.Team.Teams do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :bio, :string
    field :langueage, :string
    field :name, :string
    field :nation, :string
    field :tag, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:name, :tag, :bio, :nation, :langueage])
    |> validate_required([:name, :tag, :bio, :nation, :langueage])
  end
end
