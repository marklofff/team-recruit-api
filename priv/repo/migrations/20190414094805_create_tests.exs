defmodule TeamRecruit.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :name, :string

      timestamps()
    end

  end
end
