defmodule TeamRecruitWeb.Plugs.FetchUserPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case TeamRecruit.Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> put_resp_content_type("apllication/json")
        |> send_resp(403, Jason.encode!(%{error: "Invalid credentials"}))
        |> halt
      user ->
        assign(conn, :user, user)
    end
  end
end
