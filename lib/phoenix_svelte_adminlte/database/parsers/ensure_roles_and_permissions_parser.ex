# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Parsers.EnsureRolesAndPermissionsParser do
  @moduledoc """
  This module contains functions to parse output from db's stored procedure's calls
  """

  require Logger

  @spec parse_ensure_roles_and_permissions_result({:ok, Postgrex.Result.t()} | {:error, any()}) ::
          {:ok,
           [
             PhoenixSvelteAdminlte.Database.Models.EnsureRolesAndPermissionsItem.t()
           ]}
          | {:error, any()}
  def parse_ensure_roles_and_permissions_result({:error, reason} = err) do
    Logger.error("Error occured while calling stored procedure",
      procedure: "ensure_roles_and_permissions",
      reason: inspect(reason)
    )

    err
  end

  def parse_ensure_roles_and_permissions_result({:ok, %Postgrex.Result{rows: rows}}) do
    Logger.debug("Parsing successful response from database")

    parsed_results =
      rows
      |> Enum.map(&parse_ensure_roles_and_permissions_result_row/1)

    # todo: Handle rows that could not be parsed

    successful_results =
      parsed_results
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(&elem(&1, 1))

    Logger.debug("Parsed response")

    {:ok, successful_results}
  end

  def parse_ensure_roles_and_permissions_result_row([roles, permissions]) do
    {
      :ok,
      %PhoenixSvelteAdminlte.Database.Models.EnsureRolesAndPermissionsItem{
        roles: roles,
        permissions: permissions
      }
    }
  end

  def parse_ensure_roles_and_permissions_result_row(_unknown_row) do
    Logger.warn("Found result row that does not have valid number of columns")

    {:error, :einv_columns}
  end
end