defmodule TeamRecruit.Representer.GoogleRepresenter do
  use TeamRecruit.Representer.Map

  property :provider
  property :email
  property :name
  property :avatar, as: :picture
  property :uid, as: :sub
end
