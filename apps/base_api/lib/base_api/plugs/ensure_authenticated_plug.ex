defmodule BaseApi.Plugs.EnsureAuthenticatedPlug do
  use Guardian.Plug.Pipeline, otp_app: :base_api

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: false
end
