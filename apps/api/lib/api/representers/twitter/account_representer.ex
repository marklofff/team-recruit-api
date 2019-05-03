defmodule Api.Representer.TwitterRepresenter do
  use Api.Representer.Map

  property :provider
  property :email
  property :name
  property :avatar, as: :profile_image_url
  property :uid, as: :id_str
end
