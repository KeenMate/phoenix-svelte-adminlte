# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Parsers.GetTopPhotosParser do
  @moduledoc """
  This module contains functions to parse output from db's stored procedure's calls
  """

  require Logger

  @spec parse_get_top_photos_result({:ok, Postgrex.Result.t()} | {:error, any()}) ::
          {:ok,
           [
             PhoenixSvelteAdminlte.Database.Models.GetTopPhotosItem.t()
           ]}
          | {:error, any()}
  def parse_get_top_photos_result({:error, reason} = err) do
    Logger.error("Error occured while calling stored procedure",
      procedure: "get_top_photos",
      reason: inspect(reason)
    )

    err
  end

  def parse_get_top_photos_result({:ok, %Postgrex.Result{rows: rows}}) do
    Logger.debug("Parsing successful response from database")

    parsed_results =
      rows
      |> Enum.map(&parse_get_top_photos_result_row/1)

    # todo: Handle rows that could not be parsed

    successful_results =
      parsed_results
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(&elem(&1, 1))

    Logger.debug("Parsed response")

    {:ok, successful_results}
  end

  def parse_get_top_photos_result_row([
        photo_id,
        code,
        original_filename,
        width,
        height,
        file_size
      ]) do
    {
      :ok,
      %PhoenixSvelteAdminlte.Database.Models.GetTopPhotosItem{
        photo_id: photo_id,
        code: code,
        original_filename: original_filename,
        width: width,
        height: height,
        file_size: file_size
      }
    }
  end

  def parse_get_top_photos_result_row(_unknown_row) do
    Logger.warn("Found result row that does not have valid number of columns")

    {:error, :einv_columns}
  end
end