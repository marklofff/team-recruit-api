defmodule TeamRecruit.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password, :string
      add :email, :string
      add :userId, :string
      add :bio, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
