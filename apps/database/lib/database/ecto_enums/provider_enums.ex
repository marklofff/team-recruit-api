import EctoEnum
defenum(ProviderEnum, :provider, [:local, :steam, :google, :twitter, :discord])

defmodule ProviderEnums do
  def get_provider(provider) do
    providers = ProviderEnum.__enum_map__()
    providers[String.to_atom(provider)]
  end
end
