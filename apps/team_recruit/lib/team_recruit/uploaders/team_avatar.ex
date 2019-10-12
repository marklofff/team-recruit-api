defmodule TeamRecruit.TeamAvatar do
  @moduledoc """
  TODO: TeamAvatar
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition

  @versions [:original, :thumb]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # Whitelist file extensions:
  # def validate({file, _}) do
  #   ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  # end
  def validate({file, _}) do
    ~w(.jpg .jpeg .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 128x128^ -gravity center -extent 128x128 -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "uploads/user/avatars/#{scope.id}"
  # end
  def storage_dir(_version, {file, scope}) do
    if Map.has_key?(file, :path) do
      case String.contains?(file.path, "candidate_pics") do
        true ->
          IO.puts("dev image")
          Path.expand("/opt/app/uploads") <> "/team/avatars/#{scope.uuid}"

        false ->
          "uploads/team/avatars/#{scope.uuid}"
      end
    else
      "uploads/team/avatars/#{scope.uuid}"
    end
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
  def default_url(version, _) do
    "/images/avatars/default_#{version}.png"
  end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
