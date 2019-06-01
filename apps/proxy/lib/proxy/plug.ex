defmodule Proxy.Plug do
  @behaviour Plug

  def init(options), do: options

  def call(conn, _opts) do
    cond do
      conn.request_path =~ ~r{/admin} ->
        AdminApiWeb.Endpoint.call(conn, [])
      conn.request_path =~ ~r{/game_stats} ->
        GameStatsApiWeb.Endpoint.call(conn, [])
      true -> # default
        BaseApiWeb.Endpoint.call(conn, [])
    end
  end
end
