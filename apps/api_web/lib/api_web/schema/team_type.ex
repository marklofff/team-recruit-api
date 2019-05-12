defmodule ApiWeb.Schema.Types.TeamType do
  use Absinthe.Schema.Notation

  object :team_type do
    field(:id, :id)
    field(:name, :string)
    field(:tag, :string)
    field(:avatar, :string)
    field(:language, :string)
    field(:bio, :string)
    field(:uuid, :string)
  end

  input_object :team_input_type do
    field(:name, :string)
    field(:tag, :string)
    field(:avatar, :string)
    field(:language, :string)
    field(:bio, :string)
  end
end
