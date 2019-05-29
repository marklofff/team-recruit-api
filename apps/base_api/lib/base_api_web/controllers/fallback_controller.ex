defmodule BaseApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BaseApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BaseApi.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BaseApi.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, msg}) when is_binary(msg) do
    conn
    |> put_status(:not_found)
    |> json(%{error: msg})
  end
end
