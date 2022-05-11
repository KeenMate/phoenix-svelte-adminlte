defmodule PhoenixSvelteAdminlte.Image.Database do
  # alias PhoenixSvelteAdminlte.Image.ImageModel
  import PhoenixSvelteAdminlte.Database.DbContext

  def create_image(code, original_filename, width, height, file_size) do
    add_photo(code, original_filename, width, height, file_size)
  end

  def delete_image(code) do
    with {:ok, _} <- remove_photo(code),
         do: :ok
  end

  defp add_uuid(images) do
    Enum.map(images, fn %{code: code} = image ->
      image |> Map.put(:uuid, code) |> Map.delete(:code)
    end)
  end

  def all_images() do
    # {:ok,
    #  [
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 2,
    #      uuid: "2",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    },
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 3,
    #      uuid: "3",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    },
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 4,
    #      uuid: "4",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    },
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 5,
    #      uuid: "5",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    },
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 6,
    #      uuid: "6",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    },
    #    %ImageModel{
    #      gallery_photo_id: 1,
    #      id: 7,
    #      uuid: "7",
    #      width: 1920,
    #      height: 1080,
    #      size: 132_456
    #    }
    #  ]}
    case get_all_photos() do
      {:ok, images} ->
        {:ok, add_uuid(images)}

      error ->
        error
    end
  end

  def get_random_image(gallery_code) do
    # TODO implement

    # with {time, db_result} <-
    #        :timer.tc(fn -> Repo.query("select get_random_photo($1);", [gallery_code]) end),
    #      _ <- Logger.info("Getting random image took: #{time}"),
    #      {parsed_time, {:ok, [mapped]}} <-
    #        :timer.tc(fn -> result_to_model(db_result) end),
    #      _ <- Logger.info("Parsed random image in: #{parsed_time}") do
    #   {:ok, mapped}
    # end
  end

  def top_images(count) do
    # TODO implement

    # Repo.query("SELECT get_top_photos($1)", [count])
    # |> result_to_model()
  end

  def gallery_images(gallery_code) do
    # TODO implement
    # Repo.query("SELECT get_gallery_photos($1)", [gallery_code])
    # |> result_to_gallery_model()
  end
end
