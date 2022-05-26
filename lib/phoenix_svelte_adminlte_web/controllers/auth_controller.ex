defmodule PhoenixSvelteAdminlteWeb.AuthController do
	use PhoenixSvelteAdminlteWeb, :controller

	@oidc_client :aad

	alias PhoenixSvelteAdminlteWeb.SessionHelpers, as: Session

	require Logger

	def login(conn, _opts) do
		redirect(conn, external: OpenIDConnect.authorization_uri(@oidc_client))
	end

	def callback(conn, opts) do
		IO.puts("Login callback opts: #{inspect opts}")

		with %Plug.Conn{} = conn <- Session.create_from_callback(conn, opts, @oidc_client) do
			redirect(conn, to: "/")
		end
	end
end