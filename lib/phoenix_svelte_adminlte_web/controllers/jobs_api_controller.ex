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

  def get_job_runs(conn, %{"start" => start, "count" => count}) do
    with {{start, _}, _} <- {Integer.parse(start), :parse_start},
         {{count, _}, _} <- {Integer.parse(count), :parse_count},
         {:ok, job_runs} <- JobManager.get_job_runs(start, count),
         prepared_data <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(job_runs) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      {:error, :parse_start} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :start_nan,
          msg: "start wasnt valid number"
        )

      {:error, :parse_count} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :count_nan,
          msg: "count wasnt valid number"
        )

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

  def get_job(conn, %{"id" => job_id}) do
    with {{job_id, _}, _} <- {Integer.parse(job_id), :parse_id},
         {:ok, job} <- JobManager.get_job(job_id),
         {1, _} <- {length(job), :length},
         [prepared_data] <- PhoenixSvelteAdminlte.MapHelpers.camelize_array(job) do
      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, prepared_data)
    else
      {:error, :parse_id} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :start_nan,
          msg: "id wasnt number"
        )

      {:error, _} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :db_error,
          msg: "couldnt get data from database"
        )

      {0, :length} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn,
          reason: :not_found,
          msg: "Job with this id not found"
        )
    end
  end
end
