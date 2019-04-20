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
    |> cast(attrs, [:uuid, :nickname])
    |> cast_assoc(:social_accounts)
    |> validate_required([])
    |> TeamRecruit.Utils.check_uuid
    |> cast_attachments(attrs, [:avatar])
  end
end
