defmodule PhoenixSvelteAdminlte.Settings.Helpers do
  alias PhoenixSvelteAdminlte.Settings.Manager

  def thumbnail_sizes(), do: get_and_decode("thumbnail_sizes")

  def upload_directory(), do: get("upload_directory")

  def image_directory(), do: get("image_directory")

  defp get(key) do
    Manager.get_settings!(key).value
  end

  defp get_and_decode(key) do
    Manager.get_settings!(key).value |> Jason.decode!()
  end
end
