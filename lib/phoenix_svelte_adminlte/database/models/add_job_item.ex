# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.AddJobItem do
  @fields [
    :job_id,
    :name,
    :script_id,
    :cron
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.AddJobItem{}
end