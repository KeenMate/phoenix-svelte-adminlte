defmodule PhoenixSvelteAdminlte.Image.Maid do
  @moduledoc """
  When run, loads images and thumbnails, creating missing thumbnails and deleting thumbnails
  that are not mappable to any of existing images
  """

  require Logger
  use Task

  alias PhoenixSvelteAdminlte.Image
  alias PhoenixSvelteAdminlte.Image.Queue, as: ImageQueue
  alias PhoenixSvelteAdminlte.Image.InputImage
  alias PhoenixSvelteAdminlte.Helpers.PathHelpers
  alias PhoenixSvelteAdminlte.Image.Manager
  alias PhoenixSvelteAdminlte.Settings.Helpers, as: Settings

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_) do
    Logger.debug("Maid started to clean images")

    thumbnail_sizes = Settings.thumbnail_sizes()
    images_dir = PathHelpers.image_dir()
    upload_dir = PathHelpers.upload_dir()

    create_missing_images(images_dir, thumbnail_sizes)
    clean_upload(upload_dir, thumbnail_sizes)

    Logger.info("Maid finished cleaning task (thumbnails enqueued)")
  end

  defp clean_upload(images_dir, thumbnail_sizes) do
    upload_dir =
      images_dir
      |> Path.dirname()
      |> get_upload_directory()

    upload_dir
    |> File.ls()
    |> case do
      {:ok, files} ->
        files
        |> Enum.map(&{&1, Path.join(upload_dir, &1)})
        |> process_upload_images(images_dir, thumbnail_sizes)

        :ok

      {:error, reason} ->
        Logger.warn(
          "Could not get files from upload directory. reason: #{inspect(reason)}. path: #{upload_dir}"
        )

        :error
    end
  end

  defp process_upload_images(upload_images_paths, images_dir, thumb_sizes) do
    for {upload_filename, upload_image_path} <- upload_images_paths,
        upload_uuid = Path.rootname(upload_filename) |> Path.basename(),
        not image_exists?(upload_filename, images_dir) do
      create_input_image(upload_image_path, upload_uuid, images_dir, thumb_sizes, upload_filename)
      |> ImageQueue.enqueue_image()
    end
  end

  defp image_exists?(filename, images_dir, thumb_size \\ nil) do
    append_thumb_size =
      if thumb_size != nil do
        &String.replace(&1, ~r/\.\w+/, "_#{thumb_size}}.")
      else
        fn x -> x end
      end

    proper_filename =
      filename
      |> append_thumb_size.()

    File.regular?(Path.join(images_dir, proper_filename))
  end

  defp create_input_image(in_path, uuid, images_dir, thumb_sizes, filename) do
    %InputImage{
      input_file: in_path,
      uuid: uuid,
      output_directory: images_dir,
      thumbnail_sizes: thumb_sizes,
      original_filename: filename
    }
  end

  defp get_upload_directory(images_dir) do
    images_dir
    |> Path.join("upload")
  end

  defp create_missing_images(images_dir, thumbnail_sizes) do
    with {:ok, images} <- Manager.all_images() do
      for image <- images,
          size <- thumbnail_sizes,
          path = Manager.get_image_path(image.uuid),
          thumb_path = Manager.get_thumbnail_path(image.uuid, Integer.to_string(size)) do
        case {File.regular?(path), File.regular?(thumb_path)} do
          {true, true} ->
            nil

          {true, false} ->
            Image.Proxy.process_thumbnail(%InputImage{
              input_file: path,
              uuid: image.uuid,
              output_directory: images_dir,
              thumbnail_sizes: [size],
              original_filename: image.original_filename
            })

          {false, true} ->
            Logger.debug(
              "Image with original size does not exist but thumb #{inspect(thumb_path)} does. Trying to remove it"
            )

            File.rm(thumb_path)

          {false, false} ->
            Logger.warn(
              "Image #{inspect(image.uuid)} (even thumb for size: #{inspect(size)}) is registered in DB but is not present physically "
            )

            nil

          all_else ->
            Logger.debug("Unknown state of image: #{inspect(all_else)}")
            nil
        end
      end
    end
  end
end
