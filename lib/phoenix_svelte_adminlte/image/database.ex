defmodule PhoenixSvelteAdminlte.Image.Database do
  # alias PhoenixSvelteAdminlte.Image.ImageModel
  import PhoenixSvelteAdminlte.Database.DbContext

  def create_image(code, original_filename, width, height, file_size) do
    add_photo(code, original_filename, width, height, file_size)
  end

  def delete_image(code) do
    with {:ok, _} <- remove_photo(code),
         do: :ok
  end

  defp add_uuid(images) do
    Enum.map(images, fn %{code: code} = image ->
      image |> Map.put(:uuid, code) |> Map.delete(:code)
    end)
  end

  def all_images() do
    case get_all_photos() do
      {:ok, images} ->
        {:ok, add_uuid(images)}

      error ->
        error
    end
  end

  def get_random_image(gallery_code) do
    get_random_photo(gallery_code)
  end

  def top_images(count) do
    top_images(count)
  end

  def gallery_images(gallery_code) do
    gallery_images(gallery_code)
  end
end
