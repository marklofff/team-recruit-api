defmodule TeamRecruit.Utils do
  defp check_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, UUID.uuid4())
      _ ->
        changeset
    end
  end
end
