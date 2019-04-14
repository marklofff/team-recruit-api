defmodule TeamRecruit.Plugs.FetchUserPlug do
  import Plug.Conn

  alias TeamRecruit.Accounts
  alias TeamRecruit.Accounts.User

  def init(options) do
    options
  end

  def call(conn, _options) do
    with user <- TeamRecruit.Guardian.Plug.current_resource(conn),
         %User{} = user <- Accounts.get_user!(user.id) do
      assign(conn, :user, user)
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(403, Jason.encode!(%{error: "Invalid credentials."}))
        |> halt
    end
  end
end
