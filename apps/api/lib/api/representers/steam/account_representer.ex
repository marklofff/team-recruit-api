defmodule Api.Representer.SteamRepresenter do
  use Api.Representer.Map

  property :provider
  property :email
  property :name, as: :personaname
  property :avatar
  property :uid, as: :steamid
end
