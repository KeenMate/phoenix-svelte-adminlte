defmodule PhoenixSvelteAdminlte.User do
	@keys [:oid, :username, :display_name, :email]

	@enforce_keys @keys
	defstruct @keys

	@type t() :: %{
		oid: binary(),
		username: binary(),
		display_name: binary(),
		email: binary()
 }
end