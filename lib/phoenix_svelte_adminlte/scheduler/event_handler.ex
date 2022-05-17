defmodule PhoenixSvelteAdminlte.Scheduler.EventHandler do
  alias PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler
  alias PhoenixSvelteAdminlte.Database.DbContext
  alias PhoenixSvelteAdminlte.Helpers.LogHelpers

  require Logger

  def handle_event([:quantum, :job, event], measurements, metadata, _config) do
    if(DatabaseScheduler.is_db_job(metadata.job)) do
      handle_db_event(event, measurements, metadata)
    else
      handle_other_event(event, measurements, metadata)
    end
  end

  def handle_db_event(:start, %{system_time: native_time}, metadata) do
    Logger.info("DB JOB [#{inspect(metadata.job.name)}] Started  ")
    # get job_id from second paramet
    {_, _, [_ | [job_id]]} = metadata.job.task

    case DbContext.add_job_run(job_id, DateTime.from_unix!(native_time, :microsecond)) do
      {:ok, _} ->
        :ok

      {:error, response} ->
        LogHelpers.log_db_error(response)
    end

    :ok
  end

  def handle_db_event(event, %{duration: duration}, metadata) do
    Logger.emergency(DateTime.from_unix!(:os.system_time(:microsecond) - duration, :microsecond))
    Logger.info("DB JOB [#{metadata.job.name}} FINISHED (#{event}) ] ")

    timestamp = DateTime.from_unix!(:os.system_time(:microsecond), :microsecond)
    {_, _, [_ | [job_id]]} = metadata.job.task

    status =
      if event == :stop do
        "Finish"
      else
        "Error"
      end

    # :exception
    # :stop
    case(DbContext.complete_job_run(job_id, timestamp, status)) do
      {:ok, _} ->
        Logger.debug("completed run added to database")

      {:error, response} ->
        LogHelpers.log_db_error(response)
    end
  end

  def handle_other_event(event, _measurements, metadata) do
    # TODO handle normal job event
    Logger.info("NORMAL JOB #{event} [#{inspect(metadata.job)}]  ")
  end
end
