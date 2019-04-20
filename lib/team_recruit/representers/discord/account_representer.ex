defmodule TeamRecruit.Representer.DiscordRepresenter do
  use TeamRecruit.Representer.Map

  property :email
  property :name
  property :avatar, as: :picture
  property :uid, as: :sub
end
