defmodule Api.TeamManager.Awards do
  use Ecto.Schema
  import Ecto.Changeset

  schema "awards" do
    field :date, :date
    field :rank, :string
    field :title, :string
    belongs_to :team, Api.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(awards, attrs) do
    awards
    |> cast(attrs, [:title, :rank, :date])
    |> validate_required([:title, :rank, :date])
  end
end
