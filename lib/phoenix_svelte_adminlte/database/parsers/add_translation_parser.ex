# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Parsers.AddTranslationParser do
  @moduledoc """
  This module contains functions to parse output from db's stored procedure's calls
  """

  require Logger

  @spec parse_add_translation_result({:ok, Postgrex.Result.t()} | {:error, any()}) ::
          {:ok,
           [
             PhoenixSvelteAdminlte.Database.Models.AddTranslationItem.t()
           ]}
          | {:error, any()}
  def parse_add_translation_result({:error, reason} = err) do
    Logger.error("Error occured while calling stored procedure",
      procedure: "add_translation",
      reason: inspect(reason)
    )

    err
  end

  def parse_add_translation_result({:ok, %Postgrex.Result{rows: rows}}) do
    Logger.debug("Parsing successful response from database")

    parsed_results =
      rows
      |> Enum.map(&parse_add_translation_result_row/1)

    # todo: Handle rows that could not be parsed

    successful_results =
      parsed_results
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(&elem(&1, 1))

    Logger.debug("Parsed response")

    {:ok, successful_results}
  end

  def parse_add_translation_result_row([
        created,
        created_by,
        modified,
        modified_by,
        translation_id,
        language_code,
        data_group,
        data_object_code,
        data_object_id,
        value
      ]) do
    {
      :ok,
      %PhoenixSvelteAdminlte.Database.Models.AddTranslationItem{
        created: created,
        created_by: created_by,
        modified: modified,
        modified_by: modified_by,
        translation_id: translation_id,
        language_code: language_code,
        data_group: data_group,
        data_object_code: data_object_code,
        data_object_id: data_object_id,
        value: value
      }
    }
  end

  def parse_add_translation_result_row(_unknown_row) do
    Logger.warn("Found result row that does not have valid number of columns")

    {:error, :einv_columns}
  end
end