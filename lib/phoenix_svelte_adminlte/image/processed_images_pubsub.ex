defmodule PhoenixSvelteAdminlte.Image.ProcessedImagesPubSub do
  @moduledoc """
  Used to send notifications about processed files using PubSub
  """

  require Logger

  @topic :image_processed

  def subscribe() do
    # Logger.info("Subscribing to topic: #{inspect(@topic)}")

    PubSub.subscribe(self(), @topic)
  end

  @spec image_processed(String.t(), :ok | {:error, String.t()}) :: :ok
  def image_processed(image_uuid, status) do
    # Logger.info("Publishing to topic: #{inspect(@topic)}")

    PubSub.publish(@topic, {@topic, {image_uuid, status}})
  end

  def start_link(arg) do
    PubSub.start_link(arg)
  end

  def child_spec(init_arg) do
    PubSub.child_spec(init_arg)
  end
end
