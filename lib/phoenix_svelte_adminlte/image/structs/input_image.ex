defmodule PhoenixSvelteAdminlte.Image.InputImage do
  @keys [
    :input_file,
    :uuid,
    :output_directory,
    :thumbnail_sizes
  ]

  @enforce_keys @keys
  defstruct @keys
end
