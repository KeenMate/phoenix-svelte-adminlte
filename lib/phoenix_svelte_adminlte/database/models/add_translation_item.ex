# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule PhoenixSvelteAdminlte.Database.Models.AddTranslationItem do
  @fields [
    :created,
    :created_by,
    :modified,
    :modified_by,
    :translation_id,
    :language_code,
    :data_group,
    :data_object_code,
    :data_object_id,
    :value
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %PhoenixSvelteAdminlte.Database.Models.AddTranslationItem{}
end