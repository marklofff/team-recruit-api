defmodule Api.Representer.LocalRepresenter do
  use Api.Representer.Map

  property :provider
  property :email
  property :name, as: :nickname
  property :avatar
end
