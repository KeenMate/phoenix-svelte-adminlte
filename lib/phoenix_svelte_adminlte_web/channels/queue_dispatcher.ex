defmodule PhoenixSvelteAdminlteWeb.PhotoQueueDispatcher do
  @moduledoc """
  Used to send message over websocket that images were processed
  """

  use GenServer

  require Logger

  alias PhoenixSvelteAdminlte.Image

  def register(original_image_filename, image_uuid) do
    GenServer.cast(__MODULE__, {:register, original_image_filename, image_uuid})
  end

  # SERVER

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(arg) do
    Image.ProcessedImagesPubSub.subscribe()

    {:ok, arg}
  end

  @impl true
  def handle_cast({:register, original_image_filename, image_uuid}, state) do
    # Logger.debug(
    #   "Registering image to QueueDispatcher",
    #   image_uuid: image_uuid,
    #   original_image_filename: original_image_filename
    # )

    new_state = Map.put(state, image_uuid, original_image_filename)

    {:noreply, new_state}
  end

  @impl true
  @doc """
  Fired by Image.ProcessedImagesPubSub
  """
  def handle_info({:image_processed, {image_uuid, status}}, state) do
    # Logger.debug("ImageProcessedQueueDispatcher received image_processed",
    #   image_uuid: image_uuid,
    #   status: status
    # )

    new_state =
      case Map.pop(state, image_uuid) do
        {nil, new_state} ->
          Logger.warn("Could not find image in QueueDispatcher's map", image_uuid: image_uuid)
          new_state

        {original_filename, new_state} ->
          # Logger.debug("Sending image processed", original_filename: original_filename)

          PhoenixSvelteAdminlteWeb.Endpoint.broadcast!("photo:upload", "image_processed", %{
            filename: original_filename,
            status: status
          })

          new_state
      end

    {:noreply, new_state}
  end
end
