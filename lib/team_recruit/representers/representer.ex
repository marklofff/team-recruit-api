defmodule TeamRecruit.Representer do
  alias Ueberauth.Auth
  alias TeamRecruit.Representer.{SteamRepresenter, GoogleRepresenter, TwitterRresenter}
  alias TeamRecruit.Representer.{SteamStruct, GoogleStruct, TwitterStruct}

  def to_map(%Auth{provider: provider,
    credentials: _,
    info: info,
    uid: _uid,
    extra: %Ueberauth.Auth.Extra{raw_info: %{user: user}}
  }) do

    _to_map(%{"provider" => provider, "info" => info, "user" => user})
  end

  def _to_map(%{"provider" => :steam, "info" => info, "user" => user}) do
    SteamRepresenter.to_map(user, as: %SteamStruct{})
  end
  def _to_map(%{"provider" => :google, "info" => info, "user" => user}) do
    GoogleRepresenter.to_map(user, as: %GoogleStruct{})
  end
  def _to_map(%{"provider" => :twitter, "info" => info, "user" => user}) do
    TwitterRresenter.to_map(user, as: %TwitterStruct{})
  end
end
