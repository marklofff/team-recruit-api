defmodule Database.Representer.DiscordRepresenter do
  use Database.Representer.Map

  property :provider
  property :email
  property :name, as: :username
  property :avatar
  property :uid, as: :id
end
