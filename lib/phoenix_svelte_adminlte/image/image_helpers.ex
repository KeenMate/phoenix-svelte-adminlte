defmodule PhoenixSvelteAdminlte.Image.Helpers do
  def thumbnail_filename(uuid, size) when is_integer(size) do
    thumbnail_filename(uuid, Integer.to_string(size))
  end

  def thumbnail_filename(uuid, size) do
    uuid <> "_" <> size <> ".webp"
  end

  def image_filename(uuid) do
    uuid <> ".webp"
  end

  def generate_uuid() do
    Ecto.UUID.generate()
    |> String.replace("-", "")
  end

  def content_type_ext(content_type) do
    case content_type do
      "image/jpeg" -> ".jpg"
      "image/png" -> ".png"
      "image/webp" -> ".webp"
    end
  end
end
