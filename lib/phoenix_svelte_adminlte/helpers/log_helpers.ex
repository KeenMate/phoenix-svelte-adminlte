defmodule PhoenixSvelteAdminlte.Helpers.LogHelpers do
  def log_db_error(response) do
    Logger.error("Couldnt write to database", response: response)
  end
end
