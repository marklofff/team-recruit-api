defmodule BaseApi.Plugs.ReformatParamsPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    profile = Api.Representer.to_map(conn.params)
    provider = String.to_atom(profile.provider)

    if profile do
      assign(conn, :auth, Map.merge(profile, %{provider: provider}))
    else
      conn
    end
  end
end
