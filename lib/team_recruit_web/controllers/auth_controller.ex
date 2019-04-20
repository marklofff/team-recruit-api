defmodule TeamRecruitWeb.AuthController do
  use TeamRecruitWeb, :controller

  alias Ueberauth.Strategy.Helpers
  alias TeamRecruit.Accounts
  alias TeamRecruit.Accounts.User
  alias TeamRecruit.Guardian

  plug Ueberauth

  def request(conn, _params) do
    json(conn, %{callback_url: Helpers.callback_url(conn)})
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    json(conn, %{"success" => false})
  end

  def callback(%{assigns: %{user: user, ueberauth_auth: auth}} = conn, _params) do
    IO.puts "logged in user found!"
    with {:ok, %User{} = user} <- Accounts.find_or_create(user, auth)
    do
      render(conn, "connected_account.json", %{user: user})
    end
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    with {:ok, %User{} = user} <- Accounts.find_or_create(auth),
         {:ok, token, _claims} <- Guardian.encode_and_sign(%{"provider" => auth.provider, "resource" => user.id})
    do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Accounts.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> redirect(to: "/")
    end
  end
end
