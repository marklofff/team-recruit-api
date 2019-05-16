defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug ApiWeb.Plugs.EnsureAuthenticatedPlug
    plug ApiWeb.Plugs.FetchUserPlug
  end

  pipeline :fetch_available_user do
    plug Guardian.Plug.Pipeline,
      module: Api.Guardian,
      error_handler: Api.Guardian.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug ApiWeb.Plugs.FetchAvailableUserPlug
    plug ApiWeb.Plugs.ReformatParamsPlug
  end

  # auth required
  scope "/api/v1", ApiWeb do
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

  # API's that does not require authentication.
  scope "/api/v1", ApiWeb do
    # thirdparty
    scope "/auth" do
      pipe_through :fetch_available_user
      post "/:provider", AuthController, :callback
    end
  end

  # GraphiQL
  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug, schema: ApiWeb.Schema

    if Mix.env() == :dev do
      forward(
        "/graphiql",
        Absinthe.Plug.GraphiQL,
        schema: ApiWeb.Schema,
        context: %{pubsub: ApiWeb.Endpoint}
      )
    end
  end
end
