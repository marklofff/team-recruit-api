defmodule AdminApiWeb.Router do
  use AdminApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AdminApiWeb do
    pipe_through :api
  end
end
