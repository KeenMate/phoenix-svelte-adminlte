defmodule PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler do
  @moduledoc """
  Used for adding jobs from scheduler to database.
  You can load
  """
  require Logger
  alias PhoenixSvelteAdminlte.Scheduler
  alias PhoenixSvelteAdminlte.Scheduler.SchedulerHelper
  alias PhoenixSvelteAdminlte.Database.DbContext

  # PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler.load_jobs([%{name: :job1 ,script_id: 1,cron: "* * * * *" }])
  @doc """
  deletes old db jobs and adds new ones
  jobs is list of maps with **name, script_id and cron**
  """
  def add_jobs(jobs) do
    # Deletes old db jobs
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
    {:ok, script} = get_script(script_id)
    # just let it fail so telemetry can handle it as failure
    PhoenixSvelteAdminlte.Repo.query!(script)
    Logger.debug("Script run succesfully")
  end

  defp get_script(script_id) do
    case DbContext.get_script(script_id) do
      {:ok, [script]} ->
        {:ok, script.content}

      _ ->
        {:error, :db}
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

  def delete_db_jobs() do
    Scheduler.DbJobs.get_jobs()
    |> IO.inspect(label: "old jobs")
    |> Enum.each(fn name -> SchedulerHelper.delete_job(name) end)

    # so you arent deleting same things multiple times
    Scheduler.DbJobs.set_jobs([])
    :ok
  end

  def load_jobs() do
    case DbContext.get_jobs() do
      {:ok, jobs} ->
        jobs
        |> atomize_names()
        |> add_jobs()

      {:error, reason} ->
        Logger.error("Couldnt load jobs from db ", reason: reason)
    end
  end

  defp get_names(jobs) do
    Enum.map(jobs, & &1.name)
  end

  defp atomize_names(jobs) do
    # replaces string names with atom
    Enum.map(jobs, &Map.put(&1, :name, String.to_atom(&1.name)))
  end

  @doc """
  check if job is in list of db jobs
  """
  def is_db_job(%{name: name}) do
    Enum.member?(Scheduler.DbJobs.get_jobs(), name)
  end

  def is_db_job(_job), do: false

  # PhoenixSvelteAdminlte.Scheduler.DatabaseScheduler.add_db_job("test", "* * * * * ", "SELECT * FROM job")

  def add_db_job(name, cron, script_id) when is_number(script_id) do
    DbContext.add_job(name, cron, script_id)
  end

  def add_db_job(name, cron, content) when is_bitstring(content) do
    with {:ok, [script]} <- DbContext.add_script(name, content),
         Logger.info(inspect(script)),
         {:ok, _} <- DbContext.add_job(name, cron, script.script_id) do
      load_jobs()
    else
      {:error, reason} ->
        Logger.error("Coldnt create job and script", reason: reason)
    end
  end

  def add_script(name, content) do
    DbContext.add_script(name, content)
  end

  def delete_job(name) do
    DbContext.delete_job(name)
    load_jobs()
  end
end
