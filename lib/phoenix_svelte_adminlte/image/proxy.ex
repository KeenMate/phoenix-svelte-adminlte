defmodule PhoenixSvelteAdminlte.Image.Proxy do
  @moduledoc """
  Used as abstraction layer on top of worker-pool
  (Use this module instead of calling workers directly)
  """

  require Logger
  alias PhoenixSvelteAdminlte.Image.PilWorker, as: Worker

  def process_images(images) do
    Logger.info("Sending images for processing to worker")

    for image <- images do
      :poolboy.transaction(
        :image_worker_poolboy,
        fn pid ->
          Worker.process_image(pid, image)
        end
      )
    end
  end

  def process_image(image) do
    Logger.info("Sending image for processing to worker")

    :poolboy.transaction(
      :image_worker_poolboy,
      fn pid ->
        Worker.process_image(pid, image)
      end
    )
  end

  def process_thumbnails(images) do
    Logger.info("Sending #{Enum.count(images)} images for thumbnail generation to worker",
      image_count: Enum.count(images)
    )

    for image <- images do
      :poolboy.transaction(
        :image_worker_poolboy,
        fn pid ->
          Worker.process_thumbnail(pid, image)
        end
      )
    end
  end

  def process_thumbnail(image) do
    # Logger.info("Sending image for thumbnail generation to worker")

    :poolboy.transaction(
      :image_worker_poolboy,
      fn pid ->
        Worker.process_thumbnail(pid, image)
      end
    )
  end

  def dimensions(image_path) do
    :poolboy.transaction(:image_worker_poolboy, fn pid ->
      Worker.dimensions(pid, image_path)
    end)
  end

  def top_images(images_dir, limit \\ :all) do
    :poolboy.transaction(:image_worker_poolboy, fn pid ->
      Worker.top_images(pid, images_dir, limit)
    end)
  end

  def top_thumbnails(thumbnails_dir, size, limit \\ :all) do
    :poolboy.transaction(:image_worker_poolboy, fn pid ->
      Worker.top_thumbnails(pid, thumbnails_dir, size, limit)
    end)
  end
end
