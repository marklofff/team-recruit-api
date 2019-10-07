defmodule TeamRecruit.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nickname, :string
      add :bio, :text
      add :email, :string
      add :encrypted_password, :text

      timestamps()
    end

    create unique_index(:users, [:email])

  end
end
