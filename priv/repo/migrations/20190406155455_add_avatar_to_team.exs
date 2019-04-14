defmodule TeamRecruit.Repo.Migrations.AddAvatarToTeam do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :avatar, :string
      add :uuid, :string
    end
  end
end
