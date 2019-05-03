defmodule Api.Representer.DiscordRepresenter do
  use Api.Representer.Map

  property :provider
  property :email
  property :name, as: :username
  property :avatar
  property :uid, as: :id
end
