defmodule PhoenixSvelteAdminlteWeb.AuthController do
	use PhoenixSvelteAdminlteWeb, :controller

	alias PhoenixSvelteAdminlteWeb.SessionHelpers, as: Session
	alias PhoenixSvelteAdminlte.MapHelpers
	@oidc_client :aad

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

	def whoami(conn, _opts) do
		with {:ok, user} <- Session.current_user(conn, @oidc_client) do
			result =
				user
				|> Map.from_struct()
				|> MapHelpers.camel_cased_map_keys()

			success_response(conn, result)
		else
			{:error, :not_found} ->
				error_response(conn, response_code: 401, reason: :unauthenticated, msg: "You are not authenticated")
		end
	end
end