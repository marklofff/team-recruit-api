defmodule TeamRecruit.Accounts.User do
  import Ecto.Changeset
  use Ecto.Schema
  use Arc.Ecto.Schema

  schema "users" do
    field :email, :string
    field :name, :string
    field :userId, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    field :avatar, TeamRecruit.Avatar.Type
    field :uuid, :string
    field :bio, :string

    has_one :steam_account, TeamRecruit.Accounts.SteamAccount
    has_many :teams, TeamRecruit.TeamManager.Team
    many_to_many :games, TeamRecruit.Games.Game, join_through: "user_games"
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uuid, :name, :password, :email, :userId, :bio])
    |> validate_required([:password, :email, :userId])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> TeamRecruit.Utils.check_uuid
    |> cast_attachments(attrs, [:avatar])
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
    %{password: password}} = changeset) do
      put_change(changeset, :password, Argon2.hash_pwd_salt(password))
    end
  defp put_pass_hash(changeset), do: changeset
end
