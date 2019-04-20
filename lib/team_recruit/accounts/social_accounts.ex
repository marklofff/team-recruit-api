defmodule TeamRecruit.Accounts.SocialAccounts do
  @moduledoc """
  TODO: SocialAccounts
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "social_accounts" do
    field :email, :string
    field :name, :string
    field :avatar, :string
    field :uid, :string
    field :provider, ProviderEnum

    belongs_to :user, TeamRecruit.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(social_account, attrs) do
    social_account
    |> cast(attrs, [:email, :avatar, :name, :uid, :provider])
    |> validate_required([:avatar, :name, :uid, :provider])
    |> unique_constraint(:user_id)
  end
end