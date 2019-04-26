defmodule TeamRecruit.Representer.SteamRepresenter do
  use TeamRecruit.Representer.Map

  property :provider
  property :email
  property :name, as: :personaname
  property :avatar
  property :uid, as: :steamid
end
