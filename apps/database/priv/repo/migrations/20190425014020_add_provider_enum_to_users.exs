defmodule Database.Repo.Migrations.AddProviderEnumToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :provider, :provider
    end
  end
end
