defmodule PhoenixSvelteAdminlte.Image.PilWorker do
  @moduledoc """
  Module responsible for creating thumbnails from given images
  """

  use GenServer

  require Logger

  import PhoenixSvelteAdminlte.Image.Helpers

  alias PhoenixSvelteAdminlte.Helpers.FileHelpers
  alias PhoenixSvelteAdminlte.Image

  alias PhoenixSvelteAdminlte.Settings.Manager, as: Settings

  @lib_file :pil

  def process_image(pid, image, timeout \\ :infinity) do
    GenServer.call(pid, {:process_image, image}, timeout)
  end

  def process_thumbnail(pid, image, timeout \\ :infinity) do
    GenServer.call(pid, {:process_thumbnail, image}, timeout)
  end

  def dimensions(pid, image_path) do
    GenServer.call(pid, {:dimensions, image_path})
  end

  @doc """
  Returns absolute paths to latest modified orignal-sized images
  """
  def top_images(pid, images_dir, limit \\ :all) do
    GenServer.call(pid, {:top_images, images_dir, limit})
  end

  @doc """
  Returns absolute paths to latest modified images of given thumbnail size
  """
  def top_thumbnails(pid, thumbnails_dir, thumbnail_size, limit \\ :all) do
    GenServer.call(pid, {:top_thumbnails, thumbnails_dir, thumbnail_size, limit})
  end

  # SERVER

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  @impl true
  def init(arg) do
    # Logger.info("Initializing PIL worker")
    send(self(), {:create_port, arg})
    send(self(), :load_settings)

    {:ok, %{port: nil, arg: arg, max_size: nil}}
  end

  @impl true
  def handle_call(
        {:process_image, %{uuid: uuid, input_file: input_file} = image},
        _from,
        %{port: port, max_size: max_size} = state
      ) do
    Logger.info("Processing image #{uuid}", uuid: uuid)
    :ok = make_image(image, port, max_size)

    Image.ProcessedImagesPubSub.image_processed(uuid, :ok)

    delete_image(input_file)

    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:process_thumbnail, image}, _from, %{port: port} = state) do
    make_thumbnail(image, port)

    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:dimensions, image_path}, _from, state) do
    case get_dimensions(image_path) do
      {:ok, w, h} -> {:reply, {w, h}, state}
      :error -> {:reply, :error, state}
    end
  end

  def handle_call({:top_images, dir, limit}, _from, state) do
    res =
      case FileHelpers.map_files_only(dir) do
        {:ok, file_paths} ->
          file_paths
          |> Enum.sort(&FileHelpers.file_dates_comparer(&1, &2, :desc))
          |> handle_limited(limit)

        {:error, reason} ->
          Logger.error("Could not read content of: #{dir}", reason: inspect(reason))
          {:error, :eread}
      end

    {:reply, res, state}
  end

  @impl true
  def handle_info({:create_port, python_path}, state) do
    Logger.info("Creating Python link with path: " <> python_path)

    port_res =
      :python.start_link(
        python: String.to_charlist("python3"),
        python_path: String.to_charlist(python_path)
      )

    case port_res do
      {:ok, port} ->
        # Logger.debug("Python port started")

        {:noreply, %{state | port: port}}

      {:error, reason} ->
        Logger.error("Could not start Port for PIL worker", reason: inspect(reason))

        {:stop, :shutdown, state}
    end
  end

  def handle_info(:load_settings, state) do
    # Logger.info("load_settings called")

    case Settings.get_settings("max_image_dimensions") do
      {:ok, %{value: max_size}} ->
        # Logger.debug("Loaded max image dimensions: #{max_size}")
        {:noreply, %{state | max_size: max_size}}

      {:error, reason} ->
        # Logger.debug(
        #   "Image worker could not load max_size from settings. reason: #{inspect(reason)}",
        #   reason: inspect(reason)
        # )

        {:stop, {:shutdown, :enotinit}, state}
    end
  end

  # MEMBERS

  defp delete_image(input_filename) when is_binary(input_filename) do
    input_filename
    |> File.rm()
  end

  defp make_image(
         %PhoenixSvelteAdminlte.Image.InputImage{
           input_file: input_file,
           output_directory: output_dir,
           uuid: uuid,
           thumbnail_sizes: sizes
         },
         port,
         max_size
       ) do
    Logger.info("Processing image #{Path.basename(input_file)}",
      path: input_file
    )

    output_path = Path.join(output_dir, image_filename(uuid))

    File.mkdir_p!(Path.dirname(output_path))

    # Logger.debug("""
    # Calling convert_image
    # Input path: #{input_file}
    # Output path: #{output_path}
    # """)

    convert_image(port, input_file, output_path, nil, max_size)
    {:ok, size} = get_image_size(output_path)
    {:ok, width, height} = get_dimensions(output_path)

    for size <- sizes do
      output_path = Path.join(output_dir, thumbnail_filename(uuid, size))
      create_thumbnail(port, input_file, output_path, size)
    end

    Image.Database.create_image(uuid, width, height, size)

    :ok
  end

  defp make_thumbnail(
         %PhoenixSvelteAdminlte.Image.InputImage{
           input_file: input_file,
           output_directory: output_dir,
           uuid: uuid,
           thumbnail_sizes: sizes
         },
         port
       ) do
    for size <- sizes do
      output_path = Path.join(output_dir, thumbnail_filename(uuid, size))
      create_thumbnail(port, input_file, output_path, size)
    end
  end

  defp get_image_size(image_path) do
    case File.stat(image_path) do
      {:ok, %File.Stat{size: size}} -> {:ok, size}
      {:error, _} -> :error
    end
  end

  defp get_dimensions(image_path) do
    case File.read(image_path) do
      {:ok, content} ->
        {_, w, h, _} = ExImageInfo.info(content)
        {:ok, w, h}

      {:error, _} ->
        Logger.error("Could not read file #{image_path} to get dimesions")
        :error
    end
  end

  defp handle_limited(list, :all), do: list

  defp handle_limited(list, limit) when is_list(list) and is_number(limit),
    do: Enum.take(list, limit)

  defp create_thumbnail(port, input_path, output_path, size) do
    Logger.info("Creating thumbnail", input_path: input_path, size: size)

    convert_image(port, input_path, output_path, size)
  end

  defp convert_image(port, input_path, output_path, size \\ nil, max_size \\ nil) do
    Logger.info("Converting image", input_path: input_path, resizing: size != nil)

    # Logger.debug("PORT is: #{inspect(port)}")
    # Logger.debug("What is max_size: #{max_size}")

    python_result =
      if size == nil do
        :python.call(port, @lib_file, :create_image, [
          input_path,
          output_path,
          max_size
        ])
      else
        :python.call(port, @lib_file, :create_thumbnail, [
          input_path,
          size,
          output_path
        ])
      end

    # Logger.debug("Received result from python", result: inspect(python_result))
  end

  # defp squared_size(size) when is_binary(size) do
  #   size <> "x" <> size
  # end

  # defp squared_size(size) when is_integer(size) do
  #   str = Integer.to_string(size)
  #   str <> "x" <> str
  # end
end
