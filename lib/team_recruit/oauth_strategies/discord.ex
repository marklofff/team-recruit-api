defmodule TeamRecruit.OauthStrategies.Discord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discord" do
    field :avatar, :string
    field :discriminator, :string
    field :email, :string
    field :snowflake_id, :string
    field :username, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(discord, attrs) do
    discord
    |> cast(attrs, [:snowflake_id, :username, :discriminator, :avatar, :verified, :email])
    |> validate_required([:snowflake_id, :username, :discriminator, :avatar, :verified, :email])
  end
end
