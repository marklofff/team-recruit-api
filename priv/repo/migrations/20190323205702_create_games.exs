defmodule TeamRecruit.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :full_name, :text
      add :short_name, :text
      add :app_id, :text
      add :provider, :text

      timestamps()
    end

  end
end
