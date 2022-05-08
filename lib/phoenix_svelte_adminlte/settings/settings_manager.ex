defmodule PhoenixSvelteAdminlte.Settings.Manager do
  require Logger

  alias PhoenixSvelteAdminlte.Settings.Record

  def get_settings(key) do
    case get(key) do
      %Record{} = record -> {:ok, record}
      :not_found -> {:error, :not_found}
    end
  end

  def get_settings!(key) do
    case get(key) do
      %Record{} = record ->
        record

      :not_found ->
        Logger.error("Settings key not found", key: inspect(key))
        raise ArgumentError
    end
  end

  defp get(key) do
    case key do
      "image_directory" ->
        %Record{value: "media/images", key: "image_directory", id: 1}

      "upload_directory" ->
        %Record{value: "upload", key: "upload_directory", id: 2}

      "thumbnail_sizes" ->
        %Record{value: "[75, 400]", key: "thumbnail_sizes", id: 3}

      "max_image_dimensions" ->
        %Record{value: "1600x1200", key: "max_image_dimensions", id: 4}

      _ ->
        :not_found
    end
  end
end
