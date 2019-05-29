defmodule BaseApi.Plugs.AuthenticatedFromCookie do
  import Plug.Conn
  alias Api.Accounts

  def init(options), do: options

  def call(conn, _options) do
    {:ok, token} = Map.fetch(conn.req_cookies, "token")
    {:ok, claims} = BaseApi.Guardian.decode_and_verify(token)

    user = Accounts.get_user!(claims["sub"]["resource"])
    assign(conn, :user, user)
  end
end
