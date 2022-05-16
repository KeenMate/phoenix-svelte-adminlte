defmodule PhoenixSvelteAdminlteWeb.PhotosApiController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger
  alias PhoenixSvelteAdminlte.Image.Manager, as: ImageManager
  alias PhoenixSvelteAdminlte.Image.Helpers
  alias PhoenixSvelteAdminlteWeb.PhotoQueueDispatcher

  alias PhoenixSvelteAdminlteWeb.Router.Helpers, as: WebRoutes

  def get(conn, _params) do
    case ImageManager.all_images() do
      {:ok, images} ->
        images_with_url =
          images
          |> inscribe_image_urls(conn)
          |> add_id()

        # Logger.info("New image: #{inspect(images_with_url |> Enum.at(0))}")
        PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, images_with_url)

      {:error, reason} ->
        Logger.error("Could not load all images.", reason: inspect(reason))

        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn, %{
          msg: "Could not load all images."
        })
    end
  end

  defp inscribe_image_urls(images, conn) do
    # TODO make real routes
    images
    |> Enum.map(fn %{uuid: uuid} = image ->
      image
      |> Map.from_struct()
      |> Map.put(:original_url, WebRoutes.image_api_path(conn, :original, uuid))
      |> Map.put(:thumbnail_url, WebRoutes.image_api_path(conn, :thumbnail, uuid, 400))
    end)
  end

  defp add_id(images) do
    images
    |> Enum.map(fn %{photo_id: id} = image -> Map.put(image, :id, id) end)
  end

  def process(
        conn,
        %{"filepond" => %Plug.Upload{} = image}
      ) do
    Logger.info("Received image to be processed: #{inspect(image)}")

    uuid = Helpers.generate_uuid()

    result =
      PhoenixSvelteAdminlte.Image.Manager.save_image(
        image.path,
        uuid,
        image.content_type,
        image.filename
      )

    # Logger.debug("Registering image for Queue dispatch")
    PhotoQueueDispatcher.register(image.filename, uuid)

    case result do
      :ok -> send_resp(conn, 200, "")
      :error -> send_resp(conn, 500, "Error saving image")
    end
  end

  def process(
        conn,
        %{
          "upload" => %{
            "images" => [_ | [%Plug.Upload{} = image | _]]
          }
        }
      ) do
    uuid = Helpers.generate_uuid()

    result =
      PhoenixSvelteAdminlte.Image.Manager.save_image(
        image.path,
        uuid,
        image.content_type,
        image.filename
      )

    # Logger.debug("Registering image for Queue dispatch")
    PhotoQueueDispatcher.register(image.filename, uuid)

    case result do
      :ok -> send_resp(conn, 200, "")
      :error -> send_resp(conn, 500, "Error saving image")
    end
  end

  def delete(conn, %{"uuid" => uuid}) do
    case ImageManager.delete_image(uuid) do
      :ok ->
        send_resp(conn, 200, "")

      _ ->
        Logger.error("Couldn't delete image", image_uuid: uuid)

        conn
        |> put_status(500)
        |> json(%{message: "Couldn't delete image"})
    end
  end
end