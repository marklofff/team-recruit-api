defmodule TeamRecruit.Plugs.FetchAvailableUserPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    case TeamRecruit.Guardian.Plug.current_resource(conn) do
      nil ->
        conn
      user -> assign(conn, :user, user)
    end
  end
end
