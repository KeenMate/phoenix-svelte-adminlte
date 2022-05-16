# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.GetJobsItem do
  @fields [
    :job_id,
    :name,
    :script_id,
    :cron,
    :script_name,
    :content
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.GetJobsItem{}
end