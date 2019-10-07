defmodule TeamRecruit.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :full_name, :string
      add :short_name, :string
      add :app_id, :string
      add :provider, :string
      add :icon, :text

      timestamps()
    end

  end
end
