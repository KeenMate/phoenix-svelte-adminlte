defmodule PhoenixSvelteAdminlte.Scheduler.SchedulerHelper do
  require Logger

  def create_job(name, func, cron_expression) when is_bitstring(cron_expression) do
    case Crontab.CronExpression.Parser.parse(cron_expression) do
      {:ok, parsed_cron} ->
        create_job(name, func, parsed_cron)

      _ ->
        {:error, :invalid_cron}
    end
  end

  @doc "adds job to app scheduler. Func can either fn -> or {Module,:func,[args]}"
  def create_job(name, func, cron_expression) do
    # first delete job with same name if exists
    delete_job(name)

    PhoenixSvelteAdminlte.Scheduler.new_job()
    |> Quantum.Job.set_name(name)
    |> Quantum.Job.set_schedule(cron_expression)
    |> Quantum.Job.set_task(func)
    |> PhoenixSvelteAdminlte.Scheduler.add_job()

    :ok
  end

  def delete_job(name) do
    PhoenixSvelteAdminlte.Scheduler.delete_job(name)
  end

  def run_job(name) do
    PhoenixSvelteAdminlte.Scheduler.run_job(name)
  end
end
