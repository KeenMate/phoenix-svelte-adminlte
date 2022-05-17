# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.CompleteJobRunItem do
  @fields [
    :id,
    :start_time,
    :end_time,
    :status,
    :job_id,
    :duration
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.CompleteJobRunItem{}
end