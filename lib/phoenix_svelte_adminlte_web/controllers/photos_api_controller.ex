defmodule PhoenixSvelteAdminlteWeb.PhotosApiController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger
  alias PhoenixSvelteAdminlte.Image.Manager, as: ImageManager
  # alias PhoenixSvelteAdminlteWeb.Router.Helpers, as: WebRoutes

  def get(conn, _params) do
    case ImageManager.all_images() do
      {:ok, images} ->
        images_with_url =
          images
          |> inscribe_image_urls(conn)

        # Logger.info("New image: #{inspect(images_with_url |> Enum.at(0))}")
        PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, images_with_url)

      {:error, reason} ->
        Logger.error("Could not load all images.", reason: inspect(reason))

        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn, %{
          msg: "Could not load all images."
        })
    end
  end

  defp inscribe_image_urls(images, _conn) do
    images
    |> Enum.map(fn %{uuid: uuid} = image ->
      image
      |> Map.from_struct()
      # |> Map.put(:original_url, WebRoutes.image_api_path(conn, :original, uuid))
      # |> Map.put(:thumbnail_url, WebRoutes.image_api_path(conn, :thumbnail, uuid, 400))
      |> Map.put(:original_url, "https://picsum.photos/id/#{uuid}/1920/1080")
      |> Map.put(:thumbnail_url, "https://picsum.photos/id/#{uuid}/400/400")
    end)
  end
end
