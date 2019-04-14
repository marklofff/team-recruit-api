defmodule TeamRecruitWeb.LinkController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.{LinkManager, Guardian}
  alias TeamRecruit.Accounts.{User, SteamAccount}

  action_fallback TeamRecruitWeb.FallbackController

  def steam(conn, %{"steam" => params}) do
    with user <- TeamRecruit.Guardian.Plug.current_resource(conn),
         {:ok, %SteamAccount{} = steam_account} <- LinkManager.create_steam_account(user, params["_json"]) do
      conn
      |> json(%{success: true})
    end
  end
end
