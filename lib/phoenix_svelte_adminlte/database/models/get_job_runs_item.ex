# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.GetJobRunsItem do
  @fields [
    :id,
    :start_time,
    :end_time,
    :status,
    :job_id,
    :duration,
    :script_name,
    :job_name,
    :script_id
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.GetJobRunsItem{}
end