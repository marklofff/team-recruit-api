defmodule TeamRecruit.Accounts.User do
  @moduledoc """
  TODO: user
  """
  import Ecto.Changeset
  use Ecto.Schema
  use Arc.Ecto.Schema

  schema "users" do
    field :avatar, TeamRecruit.Avatar.Type
    field :nickname, :string
    field :uuid, :string
    field :bio, :string
    field :provider, ProviderEnum
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    # has_one :identity_account, TeamRecruit.Accounts.SteamAccount
    has_many :social_accounts, TeamRecruit.Accounts.SocialAccounts

    # has_one :twitter, TeamRecruit.Accounts.GoogleAccount
    has_many :teams, TeamRecruit.TeamManager.Team
    many_to_many :games, TeamRecruit.Games.Game, join_through: "user_games"
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uuid, :nickname, :provider])
    |> cast_assoc(:social_accounts)
    |> validate_required([])
    |> TeamRecruit.Utils.check_uuid
    |> cast_attachments(attrs, [:avatar], allow_urls: true)
  end

  @doc """
    Put Email/Password
  """
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> put_change(:encrypted_password, encrypted_password(attrs.password))
  end

  defp encrypted_password(password) do
    Argon2.hash_pwd_salt(password)
  end
end
