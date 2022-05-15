defmodule PhoenixSvelteAdminlte.Scheduler.EventHandler do
  alias PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler
  require Logger

  def handle_event([:quantum, :job, event], measurements, metadata, _config) do
    if(DatabaseScheduler.is_db_job(metadata.job)) do
      handle_db_event(event, measurements, metadata)
    else
      handle_other_event(event, measurements, metadata)
    end
  end

  def handle_db_event(event, _measurements, metadata) do
    case event do
      :exception ->
        # TODO handle db job error
        Logger.error("DB JOB [#{inspect(metadata.job)}] #{event} ")

      _ ->
        # TODO handle db job event
        Logger.info("DB JOB [#{inspect(metadata.job)}] #{event} ")
    end
  end

  def handle_other_event(event, _measurements, metadata) do
    # TODO handle normal job event
    Logger.info("NORMAL JOB [#{inspect(metadata.job)}] #{event} ")
  end
end
