# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.AddJournalMsgItem do
  @fields [
    :created,
    :created_by,
    :journal_id,
    :data_group,
    :data_object_id,
    :event_id,
    :user_id,
    :message,
    :data_payload
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.AddJournalMsgItem{}
end