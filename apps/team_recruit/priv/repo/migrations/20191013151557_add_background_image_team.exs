defmodule TeamRecruit.Repo.Migrations.AddBackgroundImageTeam do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :background_image, :string
    end

  end
end
