defmodule TeamRecruitWeb.Plugs.FetchUserPlug do
  import Plug.Conn
  alias TeamRecruit.Guardian
  alias TeamRecruit.Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claim} <- Guardian.decode_and_verify(token),
         user when not is_nil(user) <- Accounts.get_user!(claim["sub"])
    do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
