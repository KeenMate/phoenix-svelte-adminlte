defmodule PhoenixSvelteAdminlte.Initialization do
  @moduledoc """
  When run, loads images and thumbnails, creating missing thumbnails and deleting thumbnails
  that are not mappable to any of existing images
  """

  require Logger
  use Task

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_) do
    PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler.load_jobs()

    :ok =
      :telemetry.attach_many(
        # unique handler id
        "log-response-handler",
        [[:quantum, :job, :start], [:quantum, :job, :exception], [:quantum, :job, :stop]],
        &PhoenixSvelteAdminlte.Scheduler.EventHandler.handle_event/4,
        nil
      )
  end
end
