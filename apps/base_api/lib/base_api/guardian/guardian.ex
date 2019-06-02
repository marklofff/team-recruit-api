defmodule BaseApi.Guardian do
  use Guardian, otp_app: :base_api

  alias Database.Accounts
  alias Database.Accounts.User

  def subject_for_token(%User{} = user, _claims) do
    id = to_string(user.id)
    {:ok, id}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims \\ %{}) do
    user = Accounts.get_user!(claims["sub"])
    {:ok, user}
  end

  def resource_from_claims(_) do
    {:error, :reason_for_error}
  end
end
