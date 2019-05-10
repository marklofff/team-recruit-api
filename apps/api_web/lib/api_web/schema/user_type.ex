defmodule ApiWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field(:id, :id)
    field(:nickname, :string)
    field(:avatar, :string)
    field(:uuid, :string)
    field(:bio, :string)
  end

  input_object :user_input_type do
    field(:nickname, :string)
    field(:avatar, :string)
    field(:uuid, :string)
    field(:bio, :string)
  end
end
