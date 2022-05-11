# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Parsers.GetGalleryPhotosParser do
  @moduledoc """
  This module contains functions to parse output from db's stored procedure's calls
  """

  require Logger

  @spec parse_get_gallery_photos_result({:ok, Postgrex.Result.t()} | {:error, any()}) ::
          {:ok,
           [
             PhoenixSvelteAdminlte.Database.Models.GetGalleryPhotosItem.t()
           ]}
          | {:error, any()}
  def parse_get_gallery_photos_result({:error, reason} = err) do
    Logger.error("Error occured while calling stored procedure",
      procedure: "get_gallery_photos",
      reason: inspect(reason)
    )

    err
  end

  def parse_get_gallery_photos_result({:ok, %Postgrex.Result{rows: rows}}) do
    Logger.debug("Parsing successful response from database")

    parsed_results =
      rows
      |> Enum.map(&parse_get_gallery_photos_result_row/1)

    # todo: Handle rows that could not be parsed

    successful_results =
      parsed_results
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(&elem(&1, 1))

    Logger.debug("Parsed response")

    {:ok, successful_results}
  end

  def parse_get_gallery_photos_result_row([
        gallery_photo_id,
        photo_id,
        photo_code,
        width,
        height,
        file_size,
        priority
      ]) do
    {
      :ok,
      %PhoenixSvelteAdminlte.Database.Models.GetGalleryPhotosItem{
        gallery_photo_id: gallery_photo_id,
        photo_id: photo_id,
        photo_code: photo_code,
        width: width,
        height: height,
        file_size: file_size,
        priority: priority
      }
    }
  end

  def parse_get_gallery_photos_result_row(_unknown_row) do
    Logger.warn("Found result row that does not have valid number of columns")

    {:error, :einv_columns}
  end
end