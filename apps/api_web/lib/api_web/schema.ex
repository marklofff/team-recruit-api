defmodule ApiWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  alias ApiWeb.Resolvers

  import_types(ApiWeb.Schema.Types.UserType)

  # import Types
  query do
    @desc "Get a list of all users."
    field(:users, list_of(:user_type)) do
      # Resolver
      resolve(&Resolvers.User.users/3)
    end
  end

  mutation do
    @desc "Authenticates a user"
    field :login, type: :user_type do
      arg(:input, non_null(:provider))
      resolve(&Resolvers.User.login/3)
    end
  end

  #subscription do
  #
  #end
end
