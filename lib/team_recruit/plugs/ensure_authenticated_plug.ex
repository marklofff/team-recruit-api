defmodule TeamRecruit.Plugs.EnsureAuthenticatedPlug do
  use Guardian.Plug.Pipeline, otp_app: :team_recruit

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: false
end
