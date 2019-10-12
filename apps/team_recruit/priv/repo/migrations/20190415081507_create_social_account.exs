defmodule TeamRecruit.Repo.Migrations.CreateSteamAccount do
  use Ecto.Migration

  def change do
    OauthProviderEnum.create_type()

    create table(:social_accounts) do
      add :email, :string
      add :avatar, :string
      add :name, :string
      add :uid, :string
      add :provider, :provider

      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:social_accounts, [:uid])
  end
end
