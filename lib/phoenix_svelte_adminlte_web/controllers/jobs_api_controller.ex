defmodule PhoenixSvelteAdminlteWeb.JobsApiController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  alias PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler, as: JobManager
  alias PhoenixSvelteAdminlte.Database.DbContext

  def get_jobs(conn, _params) do
    with {:ok, jobs} <- DbContext.get_jobs(),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(jobs) do
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
         {:ok, jobs} <- JobManager.delete_job(num),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(jobs) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      :error ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :nan,
          msg: "parametr wasnt number"
        )

      {:error, _} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )
    end
  end

  def create_job(conn, %{"name" => name, "cron" => cron, "script" => script}) do
    with {:ok, job} <- JobManager.add_db_job(name, cron, script),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(job) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      {:error, _} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )
    end
  end

  def get_job_runs(conn, %{"start" => _start, "count" => _count}) do
    with {:ok, job_runs} <- JobManager.get_job_runs(0, 150),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(job_runs) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      {:error, _} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )
    end
  end

  def get_job_runs(conn, _params) do
    get_job_runs(conn, %{"start" => 0, "count" => 50})
  end
end
