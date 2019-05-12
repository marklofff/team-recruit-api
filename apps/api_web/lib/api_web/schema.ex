defmodule ApiWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  alias ApiWeb.Resolvers
  alias ApiWeb.Schema.Types.{UserType, TeamType}

  import_types UserType
  import_types TeamType

  # import Types
  query do
    @desc "Get a list of all users."
    field(:users, list_of(:user_type)) do
      # Resolver
      resolve(&Resolvers.User.users/3)
    end

    @desc "Get a list of all teams."
    field(:teams, list_of(:team_type)) do
      # Resolver
      resolve(&Resolvers.Team.teams/3)
    end
  end

  mutation do
    @desc "Authenticates a user"
    field :login, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.User.login/3)
    end
  end

  #subscription do
  #
  #end
end
