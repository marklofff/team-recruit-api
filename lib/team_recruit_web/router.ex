defmodule TeamRecruitWeb.Router do
  use TeamRecruitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug TeamRecruit.Plugs.EnsureAuthenticatedPlug
    plug TeamRecruit.Plugs.FetchUserPlug
  end

  # auth not required
  scope "/api", TeamRecruitWeb do
    pipe_through :api

    # thirdparty
    scope "/thirdparty" do
      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end

    # authentication
    post "/login", UserController, :login
    post "/register", UserController, :register

    # teams
    get "/teams", TeamController, :index
    get "/teams/:tag", TeamController, :show

    # user
    patch "/user", UserController, :update
    put "/user", UserController, :update
    get "/user/:userId", UserController, :show

    # games
    get "/games", GameController, :show
  end

  # auth required
  scope "/api", TeamRecruitWeb do
    pipe_through [:api, :authenticated]
    # teams
    post "/teams", TeamController, :create
    patch "/teams/:id", TeamController, :update
    put "/teams/:id", TeamController, :update
    delete "/teams/:id", TeamController, :delete
    get "/me/teams", TeamController, :get_my_teams
    post "/teams/add_game", TeamController, :add_new_game
    # end of teams

    scope "/link" do
      post "/steam", LinkController, :steam
    end

    scope "/profile" do
      get "/owned_games", ProfileController, :get_owned_games
      post "/owned_games", ProfileController, :add_owned_games
      post "/set_avatar", UserController, :set_avatar

      get "/games", ProfileController, :get_available_games
    end

    scope "/stats/csgo" do
      get "/get_user_stats_for_game", CsgoStatsController, :get_user_stats_for_game
    end
  end
end
