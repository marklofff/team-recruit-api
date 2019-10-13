import EctoEnum
defenum(
  TeamRecruit.EctoEnums.OauthProviderEnum,
  :provider,
  [:local, :steam, :google, :twitter, :discord]
)

defmodule TeamRecruit.EctoEnums.OauthProviderEnums do
  def get_provider(provider) do
    providers = OauthProviderEnum.__enum_map__()
    providers[String.to_atom(provider)]
  end
end
