defmodule PhoenixSvelteAdminlte.Image.InputImage do
  @keys [
    :input_file,
    :uuid,
    :output_directory,
    :thumbnail_sizes,
    :original_filename
  ]

  @enforce_keys @keys
  defstruct @keys
end
