defmodule PhoenixSvelteAdminlte.Image.Queue do
  use GenServer

  require Logger
  alias PhoenixSvelteAdminlte.Helpers.MsgHelpers
  alias PhoenixSvelteAdminlte.Image

  @window_duration 3000

  def enqueue_image(%PhoenixSvelteAdminlte.Image.InputImage{} = image) do
    Logger.info("queue recived in module")
    GenServer.cast(__MODULE__, {:enqueue_image, image})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_cast({:enqueue_image, image}, state) do
    Logger.info("Enqueing image",
      input_path: image.input_file,
      output_dir: image.output_directory,
      thumbnail_sizes: inspect(image.thumbnail_sizes)
    )

    MsgHelpers.window(:enqueued_images, image, @window_duration)
    {:noreply, state}
  end

  @impl true
  def handle_info({:enqueued_images, images}, state) do
    Image.Proxy.process_images(images)

    {:noreply, state}
  end
end
