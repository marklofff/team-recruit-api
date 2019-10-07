defmodule TeamRecruit.Guardian do
  use Guardian, otp_app: :team_recruit

  def subject_for_token(%TeamRecruit.Accounts.User{} = user, _claims) do
    id = to_string(user.id)
    {:ok, id}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = TeamRecruit.Accounts.get_user!(id)
    {:ok, user}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
