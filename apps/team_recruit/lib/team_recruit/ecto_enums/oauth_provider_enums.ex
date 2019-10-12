import EctoEnum
defenum(OauthProviderEnum, :provider, [:local, :steam, :google, :twitter, :discord])

defmodule OauthProviderEnums do
  def get_provider(provider) do
    providers = OauthProviderEnum.__enum_map__()
    providers[String.to_atom(provider)]
  end
end
