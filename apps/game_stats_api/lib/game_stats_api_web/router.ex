defmodule GameStatsApiWeb.Router do
  use GameStatsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GameStatsApiWeb do
    pipe_through :api
  end
end
