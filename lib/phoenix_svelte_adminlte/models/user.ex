defmodule PhoenixSvelteAdminlte.Models.User do
  @derive Jason.Encoder

  @keys [:user_id, :username, :first_name, :last_name]
  @enforce_keys @keys

  defstruct @keys
end
