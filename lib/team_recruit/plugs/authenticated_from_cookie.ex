defmodule TeamRecruit.Plugs.AuthenticatedFromCookie do
  import Plug.Conn

  alias TeamRecruit.Accounts
  alias TeamRecruit.Accounts.User

  def init(options), do: options

  def call(conn, _options) do
    {:ok, token} = Map.fetch(conn.req_cookies, "token")
    {:ok, claims} = TeamRecruit.Guardian.decode_and_verify(token)

    user = Accounts.get_user!(claims["sub"]["resource"])
    assign(conn, :user, user)
  end
end
