defmodule TeamRecruit.Repo.Migrations.AddProviderEnumToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :oauth_provider, TeamRecruit.EctoEnums.OauthProviderEnum.type()
    end
  end
end
