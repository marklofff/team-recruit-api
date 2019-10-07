defmodule TeamRecruit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: :true
    field :nickname, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nickname, :bio, :email, :encrypted_password])
    |> validate_required([:nickname, :email, :encrypted_password])
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:nickname, :email, :password])
    |> validate_required([:nickname, :email, :password])
    |> put_change(:encrypted_password, encrypted_password(attrs["password"]))
  end

  defp encrypted_password(password) do
    Argon2.hash_pwd_salt(password)
  end
end
