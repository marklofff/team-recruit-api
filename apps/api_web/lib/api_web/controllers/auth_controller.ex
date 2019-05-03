defmodule ApiWeb.AuthController do
  @moduledoc """
    AuthController
  """
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.User
  alias ApiWeb.Guardian

  action_fallback ApiWeb.FallbackController

  def callback(%{assigns: %{user: user, auth: auth}} = conn, _params) do
    with {:ok, %User{} = user} <- Accounts.find_or_create(user, auth),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def callback(%{assigns: %{auth: auth}} = conn, _params) do
    with {:ok, %User{} = user} <- Accounts.find_or_create(auth),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  @doc """
  TODO: email/password authentication
  """
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