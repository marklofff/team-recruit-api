defmodule TeamRecruit.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nickname, :string
      add :bio, :text

      timestamps()
    end
  end
end
