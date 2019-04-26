defmodule TeamRecruit.Representer do
  alias TeamRecruit.Representer.{SteamRepresenter, GoogleRepresenter, TwitterRepresenter, DiscordRepresenter}
  alias TeamRecruit.Representer.{SteamStruct, GoogleStruct, TwitterStruct, DiscordStruct}

  def to_map(params) do
    params["provider"]
    |> String.to_atom()
    |> to_map(params)
  end

  def to_map(:steam, profile) do
    SteamRepresenter.to_map(profile, as: %SteamStruct{})
  end
  def to_map(:google, profile) do
    GoogleRepresenter.to_map(profile, as: %GoogleStruct{})
  end
  def to_map(:twitter, profile) do
    TwitterRepresenter.to_map(profile, as: %TwitterStruct{})
  end
  def to_map(:discord, profile) do
    DiscordRepresenter.to_map(profile, as: %DiscordStruct{})
  end
end
