defmodule TeamRecruitWeb.Router do
  use TeamRecruitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug TeamRecruitWeb.Plugs.EnsureAuthenticatedPlug
    plug TeamRecruitWeb.Plugs.FetchUserPlug
  end

  pipeline :fetch_available_user do
    plug Guardian.Plug.Pipeline,
      module: TeamRecruit.Guardian,
      error_handler: TeamRecruit.Guardian.ErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    # plug TeamRecruitWeb.Plugs.FetchAvailableUserPlug
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TeamRecruitWeb.Schema, interface: :advanced

  scope "/api" do
    pipe_through :api

    forward  "/", Absinthe.Plug, schema: TeamRecruitWeb.Schema, json_codec: Jason

    if Mix.env() == :dev do
    else
      forward "/graphql", Absinthe.Plug, schema: TeamRecruitWeb.Schema
    end

  end

  scope "/api/v1",TeamRecruitWeb, as: :v1 do
    pipe_through [:api]

    resources "/teams", TeamController, only: [:index]
    get "/teams/:tag", TeamController, :show
    get "/players/nickname/:nickname", UserController, :show

    # JoinRequests
    post "/teams/join_request/create", JoinRequestController, :create
    get "/team/:id/join_request/list", JoinRequestController, :list_join_requests
    post "/teams/join_request/accept/:id", JoinRequestController, :accept_join_request
    delete "/teams/join_request/delete/:id", JoinRequestController, :delete_join_request


    # Players
    resources "/players", UserController, only: [:index]

    # Oauth
    scope "/oauth" do
      pipe_through :fetch_available_user

      post "/:provider", AuthController, :callback
    end

    get "/me", UserController, :me
    get "/me/teams", TeamController, :get_my_teams
    # get "/me/notifications", InvitationController, :index

    resources "/teams", TeamController
    resources "/players", UserController, only: [:show]

    get "/top_teams", TeamController, :index
    get "/top_players", UserController, :index
  end
end
