defmodule Database.Representer.SteamRepresenter do
  use Database.Representer.Map

  property :provider
  property :email
  property :name, as: :personaname
  property :avatar
  property :uid, as: :steamid
end
