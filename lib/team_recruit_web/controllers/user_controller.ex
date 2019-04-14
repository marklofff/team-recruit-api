defmodule TeamRecruitWeb.UserController do
  use TeamRecruitWeb, :controller

  alias TeamRecruit.{Accounts, Guardian}
  alias TeamRecruit.Accounts.User

  action_fallback TeamRecruitWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"userId" => userId}) do
    user = Accounts.get_user_by_userId!(userId)
    render(conn, "user.json", user: user)
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> render("show.json", user: user)
    end
  end

  def login(conn, %{"user" => %{"password" => password, "email" => email}} = params) do
   case Accounts.sign_in(params["user"]) do
     {:error, message} ->
       {:error, :not_found}
     {:ok, %User{} = user} ->
       {:ok, token, _claims} = Guardian.encode_and_sign(user)
       render(conn, "login.json", %{user: user, token: token})
    end
  end

  def set_avatar(conn, %{"avatar" => avatar}) do
    with current_resource <- TeamRecruit.Guardian.Plug.current_resource(conn) do
      user = Accounts.get_user!(current_resource.id)

      case Accounts.update_user(user, %{avatar: avatar}) do
        {:ok, %User{} = user} ->
          json(conn, %{"success" => true})
        {:error, _} ->
          json(conn, %{"success" => false})
      end
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = Accounts.get_user!(user_params["id"])

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
