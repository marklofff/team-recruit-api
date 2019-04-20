defmodule TeamRecruitWeb.UserControllerTest do
  @moduledoc """
  The Accounts context.
  """

  use TeamRecruitWeb.ConnCase
  import TeamRecruit.Factory

  alias TeamRecruit.Accounts
  alias TeamRecruit.Accounts.User

  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "some password",
    userId: "some userId"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    password: "some updated password",
    userId: "some updated userId"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil, userId: nil}

  defp valid_user(_context) do
    user = insert(:user)
    [user: user]
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "update user" do
    setup [:valid_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      current_user = %{
        id: user.id,
        name: user.name,
        email: user.email,
        uid: user.uid,
      }

      params = Map.merge(@update_attrs, current_user)
      conn = put(conn, Routes.user_path(conn, :update, %{user: params}))
      response = json_response(conn, 200)["data"]
      assert %{"id" => ^id} = response
      %{"userId" => user_id} = response

      conn = get(conn, Routes.user_path(conn, :show, userId))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "name" => "some updated name",
               "password" => "some updated password",
               "userId" => "some updated userId"
             } = response
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:valid_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

end
