defmodule TeamRecruit.Repo.Migrations.AddMessagesToJoinRequests do
  use Ecto.Migration

  def change do
    alter table(:join_requests) do
      add :accepted, :boolean
      add :message, :text
      add :denied_reason, :text
    end

  end
end
