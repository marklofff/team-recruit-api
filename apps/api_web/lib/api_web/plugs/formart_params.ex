defmodule ApiWeb.Plugs.ReformatParamsPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    IO.inspect(conn.params)

    case Api.Representer.to_map(conn.params) do
      profile ->
        IO.inspect(profile)
        provider = String.to_atom(profile.provider)
        assign(conn, :auth, Map.merge(profile, %{provider: provider}))

      _ ->
        conn
    end
  end
end
