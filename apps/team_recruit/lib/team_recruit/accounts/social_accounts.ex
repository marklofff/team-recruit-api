defmodule TeamRecruit.Accounts.SocialAccounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "oauth_social_accounts" do
    field :email, :string
    field :name, :string
    field :avatar, :string
    field :uid, :string
    field :provider, OauthProviderEnums

    belongs_to :user, TeamRecruit.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(social_account, attrs) do
    social_account
    |> cast(attrs, [:email, :avatar, :name, :uid, :provider])
    |> validate_required([:name, :provider])
    |> unique_constraint(:user_id)
  end
end
