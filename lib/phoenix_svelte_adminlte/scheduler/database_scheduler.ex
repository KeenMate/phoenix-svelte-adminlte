defmodule PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler do
  @moduledoc """
  Used for adding jobs from scheduler to database.
  You can load
  """
  require Logger
  alias PhoenixSvelteAdminlte.Scheduler
  alias PhoenixSvelteAdminlte.Scheduler.SchedulerHelper

  # PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler.load_jobs([%{name: :job1 ,script_id: 1,cron: "* * * * *" }])
  @doc """
  deletes old db jobs and adds new ones
  jobs is list of maps with **name, script_id and cron**
  """
  def load_jobs(jobs) do
    Scheduler.DbJobs.get_jobs()

    # deletes old db jobs
    delete_db_jobs()

    Enum.each(jobs, fn job -> create_db_job(job.name, job.script_id, job.cron) end)

    get_names(jobs)
    |> IO.inspect(label: "new jobs")
    |> Scheduler.DbJobs.set_jobs()

    :ok
  end

  @doc """
  gets script with coresponding from database and runs it
  """
  def run_database_script(script_id) do
    # get script from database
    case get_script(script_id)
         |> PhoenixSvelteAdminlte.Repo.query() do
      {:ok, _} ->
        Logger.debug("Script run succesfully")

      {:error, reason} ->
        Logger.info(inspect(reason))
        Logger.error("Error running db query", reason: reason)
    end
  end

  defp get_script(script_id) do
    # TODO replace with getting real script
    case script_id do
      1 ->
        ~s(
				DELETE
				FROM photo
			)

      2 ->
        "12564131dawda"
    end
  end

  @doc """
  adds new job that will run db script with coresponding code
  """
  def create_db_job(name, script_id, cron_expression) do
    SchedulerHelper.create_job(
      name,
      {PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler, :run_database_script, [script_id]},
      cron_expression
    )
  end

  defp get_names(jobs) do
    Enum.map(jobs, & &1.name)
  end

  def delete_db_jobs() do
    Scheduler.DbJobs.get_jobs()
    |> IO.inspect(label: "old jobs")
    |> Enum.each(fn name -> SchedulerHelper.delete_job(name) end)

    # so you arent deleting same things multiple times
    Scheduler.DbJobs.set_jobs([])
    :ok
  end
end
