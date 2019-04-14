defmodule TeamRecruit.Repo.Migrations.CreateDiscord do
  use Ecto.Migration

  def change do
    create table(:discord) do
      add :snowflake_id, :string
      add :username, :string
      add :discriminator, :string
      add :avatar, :string
      add :verified, :boolean, default: false, null: false
      add :email, :string

      timestamps()
    end

  end
end
