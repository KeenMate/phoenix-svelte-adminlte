defmodule PhoenixSvelteAdminlte.SchedulerHelper do
  import Crontab.CronExpression

  def createJob(name, func, cron_expression) do
    PhoenixSvelteAdminlte.Scheduler.new_job()
    |> Quantum.Job.set_name(name)
    |> Quantum.Job.set_schedule(cron_expression)
    |> Quantum.Job.set_task(func)
    |> PhoenixSvelteAdminlte.Scheduler.add_job()
  end
end
