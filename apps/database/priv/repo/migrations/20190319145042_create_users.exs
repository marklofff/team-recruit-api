defmodule Database.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nickname, :text
      add :bio, :text
      add :email, :text
      add :encrypted_password, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
