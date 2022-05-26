defmodule PhoenixSvelteAdminlteWeb.SessionHelpers do
	require Logger
	alias Plug.Conn
	alias KeenAuth.Helpers.Date
	alias KeenAuth.Helpers.JwtHelpers

	@access_token_base "access_token"
	@id_token_base "id_token"

	# Session handling

	def create_from_callback(conn, params, client) when is_atom(client) do
		with {:ok, tokens} <- OpenIDConnect.fetch_tokens(client, params) do
			create(conn, tokens, client)
		end
	end

	def create(conn, %{"access_token" => access_token, "id_token" => id_token} = tokens, client) when is_atom(client) do
		with {:ok, _} <- OpenIDConnect.verify(client, id_token) do
			conn
			|> put_required_tokens(tokens, client)
			|> try_putting_refresh_token(tokens, client)
		end
	end

	def destroy(conn, client) do
		conn
		|> delete_tokens(client)
	end

	# Token handling

	defp put_required_tokens(conn, %{"access_token" => access_token, "id_token" => id_token}, client) do
		conn
		|> put_access_token(access_token, client)
		|> put_id_token(id_token, client)
	end

	defp try_putting_refresh_token(conn, %{"refresh_token" => refresh_token} = resp, client) do
		with {:ok, exp} <- Map.fetch(resp, "expires_in") do
			put_refresh_token(conn, refresh_token, client, exp)
		else
			_ -> put_refresh_token(conn, refresh_token, client)
		end
	end

	defp try_putting_refresh_token(conn, %{} = _, _), do: conn

	def delete_tokens(conn, client) do
		conn
		|> delete_access_token(client)
		|> delete_id_token(client)
		|> delete_refresh_token(client)
	end

	# Access token

	def get_access_token(conn, client) do
		Conn.get_session(conn, access_token_key(client))
	end

	defp put_access_token(conn, access_token, client) when is_binary(access_token) do
		Conn.put_session(conn, access_token_key(client), access_token)
	end

	defp delete_access_token(conn, client) do
		Conn.delete_session(conn, access_token_key(client))
	end

	# ID token

	def get_id_token(conn, client) do
		Conn.get_session(conn, id_token_key(client))
	end

	defp put_id_token(conn, id_token, client) when is_binary(id_token) do
		Conn.put_session(conn, id_token_key(client), id_token)
	end

	defp delete_id_token(conn, client) do
		Conn.delete_session(conn, id_token_key(client))
	end

	def get_identity(conn, client) do
		id_token = get_id_token(conn, client)

		OpenIDConnect.verify(client, id_token)
	end

	# Refresh token

	def get_refresh_token(conn, client) do
		Map.get(conn.req_cookies, cookie_key(client))
	end

	defp put_refresh_token(conn, refresh_token, client) when is_binary(refresh_token) do
		with {:ok, token_expiration} <- JwtHelpers.token_expiration(refresh_token),
		     expiration <- Date.diff_now(token_expiration) do
			put_refresh_token(conn, refresh_token, client, expiration)
		else
			_ ->
				put_refresh_token(conn, refresh_token, client, 604800) # 7 days expiration by default
		end
	end

	defp put_refresh_token(conn, _, _), do: conn

	# expiration in seconds
	defp put_refresh_token(conn, refresh_token, client, expiration) when is_binary(refresh_token) do
		Conn.put_resp_cookie(
			conn,
			cookie_key(client),
			refresh_token,
			http_only: true,
			max_age: expiration
		)
	end

	defp put_refresh_token(conn, _, _, _), do: conn

	defp delete_refresh_token(conn, client) do
		Conn.delete_resp_cookie(conn, cookie_key(client))
	end

	# Key helpers

	def cookie_key(client) do
		get_in(Application.get_env(:keen_auth, :clients), [client, :refresh_token_cookie_key]) || Atom.to_string(client) <> "_rt"
	end

	defp access_token_key(client) do
		@access_token_base <> "_" <> Atom.to_string(client)
	end

	defp id_token_key(client) do
		@id_token_base <> "_" <> Atom.to_string(client)
	end

	defp refresh_token_expiration_key(client) do
		get_in(Application.get_env(:phoenix_svelte_adminlte, :openid_connect_providers), [client, :refresh_token_exp_key])
	end
end