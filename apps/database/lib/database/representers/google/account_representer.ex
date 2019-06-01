defmodule Database.Representer.GoogleRepresenter do
  use Database.Representer.Map

  property :provider
  property :email
  property :name
  property :avatar, as: :picture
  property :uid, as: :sub
end
