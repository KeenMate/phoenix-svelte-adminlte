defmodule PhoenixSvelteAdminlte.Image.Manager do
  require Logger
  import PhoenixSvelteAdminlte.Image.Helpers
  alias PhoenixSvelteAdminlte.Image
  alias PhoenixSvelteAdminlte.Helpers.PathHelpers

  # get
  def all_images() do
    Image.Database.all_images()
  end

  # save

  def save_image(image_path, uuid, content_type) do
    filename = uuid <> content_type_ext(content_type)

    case copy_to_upload(image_path, filename) do
      {:ok, path} ->
        # Logger.info("Image copied to uploaded directory")
        Logger.info(Path.dirname(PathHelpers.image_dir()))
        Logger.info("Going to query it now...")

        input_image(path, uuid, PathHelpers.image_dir(), [75, 400])
        |> PhoenixSvelteAdminlte.Image.Queue.enqueue_image()

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

  def get_image_path(uuid) do
    Path.join(PathHelpers.image_dir(), image_filename(uuid))
  end

  def get_thumbnail_path(uuid, size) do
    Path.join(PathHelpers.image_dir(), thumbnail_filename(uuid, size))
  end

  def get_random_image(gallery_code) do
    Image.Database.get_random_image(gallery_code)
  end

  def image_dimensions(uuid) do
    Image.Proxy.dimensions(get_image_path(uuid))
  end
end
