defmodule TeamRecruit.Representer.LocalRepresenter do
  use TeamRecruit.Representer.Map

  property :provider
  property :email
  property :name, as: :nickname
  property :avatar
end
