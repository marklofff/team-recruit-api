defmodule TeamRecruit.Representer.TwitterRepresenter do
  use TeamRecruit.Representer.Map

  property :provider
  property :email
  property :name
  property :avatar, as: :profile_image_url
  property :uid, as: :id_str
end
