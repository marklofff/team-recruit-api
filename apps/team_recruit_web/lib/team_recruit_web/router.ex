defmodule TeamRecruitWeb.Router do
  use TeamRecruitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TeamRecruitWeb do
    pipe_through :api

    post "/login", AuthController, :login
    post "/register", AuthController, :register
  end
end
