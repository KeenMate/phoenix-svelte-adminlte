defmodule PhoenixSvelteAdminlte.Scheduler.EventHandler do
  alias PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler
  alias PhoenixSvelteAdminlte.Database.DbContext

  require Logger

  def handle_event([:quantum, :job, event], measurements, metadata, _config) do
    if(DatabaseScheduler.is_db_job(metadata.job)) do
      handle_db_event(event, measurements, metadata)
    else
      handle_other_event(event, measurements, metadata)
    end
  end

  def handle_db_event(event, measurements, metadata) do
    # case event do
    #   :exception ->
    #     DbContext.add_job_run(:os.system_time(:millisecond), nil, metadata.job.name, "Start")

    #   :start ->
    #     DbContext.add_job_run(nil, :os.system_time(:millisecond), metadata.job.name, "Error")

    #   :stop ->
    #     DbContext.add_job_run(nil, :os.system_time(:millisecond), metadata.job.name, "Finish")
    # end

    Logger.info("DB JOB [#{inspect(metadata)}] [#{inspect(measurements)}] #{event} ")

    :ok
  end

  def handle_other_event(event, _measurements, metadata) do
    # TODO handle normal job event
    Logger.info("NORMAL JOB [#{inspect(metadata.job)}] #{event} ")
  end
end
