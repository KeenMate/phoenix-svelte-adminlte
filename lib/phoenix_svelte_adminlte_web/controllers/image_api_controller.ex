defmodule PhoenixSvelteAdminlteWeb.ImageApiController do
  @doc """
  controller used for retrieving image files and info about them
  """

  use PhoenixSvelteAdminlteWeb, :controller

  require Logger

  alias PhoenixSvelteAdminlte.Image

  def original(conn, %{"uuid" => uuid}) do
    result_path = Image.Manager.get_image_path(uuid)

    conn
    |> return_file(result_path)
  end

  def dimensions(conn, %{"uuid" => uuid}) do
    # TODO return real dimensions
    # result_path = Image.Manager.get_image_path(uuid)

    # {w, h} = Image.Proxy.dimensions(result_path)

    {w, h} = {1920, 1080}

    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(200, %{w: w, h: h} |> Jason.encode!())
  end

  def thumbnail(conn, %{"uuid" => uuid, "thumbnail_size" => size}) do
    result_path = Image.Manager.get_thumbnail_path(uuid, size)

    conn
    |> set_cache()
    |> return_file(result_path)
  end

  # HELPERS

  defp return_file(conn, path) do
    case File.read(path) do
      {:ok, data} ->
        conn
        |> set_cache()
        |> send_resp(200, data)

      {:error, :enoent} ->
        Logger.error("Couldn't find image on path #{path}", path: path)
        send_resp(conn, 404, "Image not found")

      {:error, _} ->
        Logger.error("Error while reading image on path #{path}", path: path)
        send_resp(conn, 500, "Server error")
    end
  end

  defp set_cache(conn) do
    conn
    |> put_resp_header("cache-control", "max-age=604800, private")
  end
end
