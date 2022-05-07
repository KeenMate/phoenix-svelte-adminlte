defmodule PhoenixSvelteAdminlte.Image.ImageModel do
  @keys [
    :id,
    :uuid,
    :width,
    :height,
    :size
  ]

  @enforce_keys @keys

  @derive Jason.Encoder
  defstruct [:gallery_photo_id | @keys]
end
