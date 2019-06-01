defmodule Database.Representer.LocalRepresenter do
  use Database.Representer.Map

  property :provider
  property :email
  property :name, as: :nickname
  property :avatar
end
