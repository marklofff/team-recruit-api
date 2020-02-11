defmodule TeamRecruitWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias TeamRecruitWeb.{Data, Resolvers}

  @desc "A user of the site"
  object :user do
    field :id, :id
    field :nickname, :string
    field :bio, :string
    field :email, :string
    field :encrypted_password, :string
  end

  object :user_queries do
    @desc "Search users"
    field :search_users, list_of(:user) do
      arg(:search_term, non_null(:string))

      resolve(&Resolvers.UserResolver.search_users/3)
    end

    @desc "Get current user"
    field :current_user, :user do
      resolve(&Resolvers.UserResolver.current_user/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register, type: :session_type do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.UserResolver.authenticate/3)
    end

    @desc "Login and retrive a jwt token"
    field :login, type: :session_type do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.UserResolver.signup/3)
    end
  end
end
