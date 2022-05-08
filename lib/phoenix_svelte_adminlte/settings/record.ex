defmodule PhoenixSvelteAdminlte.Settings.Record do
  @keys [:id, :key, :value]
  @enforce_keys @keys

  @derive Jason.Encoder
  defstruct @keys
end
