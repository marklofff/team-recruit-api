defmodule BaseApiWeb.Router do
  use BaseApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug BaseApi.Plugs.EnsureAuthenticatedPlug
    plug BaseApi.Plugs.FetchUserPlug
  end

  pipeline :fetch_available_user do
    plug Guardian.Plug.Pipeline,
      module: Api.Guardian,
      error_handler: Api.Guardian.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug BaseApi.Plugs.FetchAvailableUserPlug
    plug BaseApi.Plugs.ReformatParamsPlug
  end

  scope "/api/v1", BaseApiWeb do
    scope "/auth" do
      post "/register", AuthController, :register
      post "/login", AuthController, :login
    end

    resources "/teams", TeamController, only: [:index]
    resources "/players", UserController, only: [:index]

    scope "/auth" do
      pipe_through :fetch_available_user
      post "/:provider", AuthController, :callback
    end
  end

  scope "/api/v1", BaseApiWeb do
    pipe_through [:api, :authenticated]

    get "/me", UserController, :me
    get "/me/teams", TeamController, :get_my_teams
    get "/me/notifications", InvitationController, :index

    resources "/teams", TeamController do
      resources "/apply", ApplyController
    end

    resources "/players", UserController, only: [:show] do
      resources "/invitation", InvitationController
    end
  end
end
