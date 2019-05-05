defmodule ApiWeb.LinkView do
  use ApiWeb, :view
  alias ApiWeb.LinkView

  def render("steam.json", %{steam: steam}) do
    %{
      avatar: steam.avatar,
      avatarfull: steam.avatarfull,
      avatarmedium: steam.avatarmedium,
      communityvisibilitystate: steam.communityvisibilitystate,
      personaname: steam.personaname,
      profilestate: steam.personaname,
      profileurl: steam.profileurl,
      steamid: steam.steamid
    }
  end
end
