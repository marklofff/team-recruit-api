defmodule TeamRecruit.Repo.Migrations.CreateSteamAccount do
  use Ecto.Migration

  def change do
    TeamRecruit.EctoEnums.OauthProviderEnum.create_type()

    create table(:oauth_social_accounts) do
      add :email, :string
      add :avatar, :string
      add :name, :string
      add :uid, :string
      add :provider, TeamRecruit.EctoEnums.OauthProviderEnum.type()

      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:oauth_social_accounts, [:uid])
  end
end
