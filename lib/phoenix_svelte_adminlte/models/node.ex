defmodule PhoenixSvelteAdminlte.Models.Node do
  @derive Jason.Encoder

  @keys [:node_path, :title, :has_children,:priority,:is_draggable]
  @enforce_keys [:node_path, :title]

  defstruct @keys
end
