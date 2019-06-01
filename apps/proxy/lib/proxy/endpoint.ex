defmodule Proxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :proxy

  plug Proxy.Plug, %{
    "default" => BaseApiWeb.Endpoint,
    "admin" => AdminApiWeb.Endpoint,
    "game_stats_api" => GameStatsApiWeb.Endpoint
  }

  def init(_key, config) do
    updated_config =
      config
      |> configure_port()

    {:ok, updated_config}
  end

  defp configure_port(config) do
    if config[:load_port_from_system_env] do
      port =
        System.get_env("PROXY_PORT") ||
          raise "expected the PROXY_PORT environment variable to be set"

      Keyword.put(config, :http, ip: {0, 0, 0, 0}, port: port)
    else
      config
    end
  end
end
