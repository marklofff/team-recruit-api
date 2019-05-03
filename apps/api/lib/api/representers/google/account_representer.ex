defmodule Api.Representer.GoogleRepresenter do
  use Api.Representer.Map

  property :provider
  property :email
  property :name
  property :avatar, as: :picture
  property :uid, as: :sub
end
