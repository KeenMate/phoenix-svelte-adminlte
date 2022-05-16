defmodule PhoenixSvelteAdminlteWeb.JobsApiController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  alias PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler, as: JobManager
  alias PhoenixSvelteAdminlte.Database.DbContext

  def get_jobs(conn, _params) do
    with {:ok, jobs} <- DbContext.get_jobs(),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(jobs) do
      JobManager.load_jobs()
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      {:error, reason} ->
        Logger.error("Error getting jobs from db", reason: reason)

        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )
    end
  end

  def delete_job(conn, %{"id" => id}) do
    Logger.info("DELETING JOB")

    with {num, _} <- Integer.parse(id),
         {:ok, jobs} <- DbContext.delete_job(num),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(jobs) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      :error ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :nan,
          msg: "parametr wasnt number"
        )

      {:error, reason} ->
        Logger.error("Error getting jobs from db", reason: reason)

        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )
    end
  end
end
