defmodule Api.Repo.Migrations.CreateAwards do
  use Ecto.Migration

  def change do
    create table(:awards) do
      add :title, :text
      add :rank, :text
      add :date, :date
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:awards, [:team_id])
  end
end
