defmodule TeamRecruitWeb.CsgoStatsController do
  use TeamRecruitWeb, :controller

  action_fallback TeamRecruitWeb.FallbackController

  def get_user_stats_for_game(conn, %{"steamid" => steamid}) do
    params = %{
      steamid: steamid,
      appid: 730
    }

    stats =  SteamEx.ISteamUserStats.get_user_stats_for_game("", params)
    json(conn, %{stats: Jason.decode!(stats.body)})
  end
end
