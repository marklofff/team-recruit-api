defmodule BaseApiWeb.AuthController do
  @moduledoc """
  AuthController
  """
  use BaseApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.User
  alias BaseApi.Guardian

  action_fallback BaseApiWeb.FallbackController

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

  def register(%{assigns: %{auth: auth}} = conn, _params) do
    with %User{} = user <- Accounts.create_user_from_profile(auth),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def login(%{assigns: %{auth: auth}} = conn, _params) do
    with %User{} = user <- Accounts.get_user_by_email(:local, auth.email),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "authenticated_user.json", %{token: token, user: user})
    end
  end

  def callback(_conn, _params) do
    {:error, "Invalid Params."}
  end
end
