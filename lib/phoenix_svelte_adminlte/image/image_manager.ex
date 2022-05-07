defmodule PhoenixSvelteAdminlte.Image.Manager do
  require Logger
  import PhoenixSvelteAdminlte.Image.Helpers
  alias PhoenixSvelteAdminlte.Image.ImageModel
  alias PhoenixSvelteAdminlte.Helpers.PathHelpers

  # get
  def all_images() do
    {:ok,
     [
       %ImageModel{
         gallery_photo_id: 1,
         id: 2,
         uuid: "2",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 3,
         uuid: "3",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 4,
         uuid: "4",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 5,
         uuid: "5",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 6,
         uuid: "6",
         width: 1920,
         height: 1080,
         size: 132_456
       },
       %ImageModel{
         gallery_photo_id: 1,
         id: 7,
         uuid: "7",
         width: 1920,
         height: 1080,
         size: 132_456
       }
     ]}
  end

  # save

  def save_image(image_path, uuid, content_type) do
    filename = uuid <> content_type_ext(content_type)

    case copy_to_upload(image_path, filename) do
      {:ok, path} ->
        # Logger.info("Image copied to uploaded directory")
        Logger.info(Path.dirname(PathHelpers.image_dir()))

        # TODO add to que
        # input_image(path, uuid, PathHelpers.image_dir(), [75, 400])
        # |> Pluto.Image.Queue.enqueue_image()

        :ok

      {:error, reason} ->
        Logger.error("Error copying image to uploaded directory, reason: #{reason}",
          reason: inspect(reason)
        )

        :error
    end
  end

  defp input_image(input_path, uuid, output_dir, thumbnail_sizes) do
    %PhoenixSvelteAdminlte.Image.InputImage{
      input_file: input_path,
      uuid: uuid,
      output_directory: output_dir,
      thumbnail_sizes: thumbnail_sizes
    }
  end

  defp copy_to_upload(source, new_name) do
    destination = Path.join(PathHelpers.upload_dir(), new_name)

    File.mkdir_p!(Path.dirname(destination))

    case File.cp(source, destination) do
      :ok ->
        {:ok, destination}

      {:error, _reason} = error ->
        Logger.error(
          "Could not copy path: #{inspect(source)}, #{inspect(destination)}, exists?: #{File.exists?(destination)}"
        )

        error
    end
  end
end
