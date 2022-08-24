defmodule PhoenixSvelteAdminlteWeb.Auth.EmailAuthenticationHandler do
  @behaviour KeenAuth.EmailAuthenticationHandler

  alias KeenAuthPermissions.Email

  @impl true
  @spec authenticate(conn :: Plug.Conn.t(), params :: map()) ::
          {:ok, map()} | {:error, :unauthenticated}
  def authenticate(conn, params) do
    Email.authenticate(conn, params["email"], params["password"], fn password, hash -> true end)
  end

  @impl true
  @spec handle_unauthenticated(conn :: Plug.Conn.t(), params :: map()) :: Plug.Conn.t()
  def handle_unauthenticated(conn, params) do
    conn
  end

  @impl true
  @spec handle_authenticated(conn :: Plug.Conn.t(), user :: KeenAuth.User.t()) ::
          Plug.Conn.t()
  def handle_authenticated(conn, user) do
    conn
  end
end
