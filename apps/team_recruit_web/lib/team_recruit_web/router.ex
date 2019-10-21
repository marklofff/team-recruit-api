defmodule TeamRecruitWeb.Router do
  use TeamRecruitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    #plug TeamRecruitWeb.Plugs.EnsureAuthenticatedPlug
    #plug TeamRecruitWeb.Plugs.FetchUserPlug
  end

  pipeline :fetch_available_user do
    plug Guardian.Plug.Pipeline,
      module: TeamRecruit.Guardian,
      error_handler: TeamRecruit.Guardian.ErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    # plug TeamRecruitWeb.Plugs.FetchAvailableUserPlug
  end

  scope "/api", TeamRecruitWeb do
    pipe_through [:api]

    post "/register", AuthController, :register
    post "/login", AuthController, :login

    resources "/teams", TeamController, only: [:index]
    resources "/players", UserController, only: [:index]

    scope "/oauth" do
      pipe_through :fetch_available_user

      post "/:provider", AuthController, :callback
    end

    get "/me", UserController, :me
    get "/me/teams", TeamController, :get_my_teams
    # get "/me/notifications", InvitationController, :index

    resources "/teams", TeamController do
      resources "/apply", ApplyController
    end

    resources "/players", UserController, only: [:show] do
      resources "/invitation", InvitationController
    end

  end
end
