defmodule PhoenixSvelteAdminlte.Models.Node do
  @derive Jason.Encoder

  @keys [:node_path, :title, :has_children]
  @enforce_keys [:node_path, :title]

  defstruct @keys
end
