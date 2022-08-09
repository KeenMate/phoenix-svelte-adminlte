defmodule PhoenixSvelteAdminlteWeb.AdminController do
  use PhoenixSvelteAdminlteWeb, :controller

  alias KeenAuth.Plug.Authorize
  alias KeenAuth.Plug.RequireAuthenticated

  import Authorize

  plug RequireAuthenticated, storage: KeenAuth.Config.get_storage(), login_path: Application.get_env(:keen_auth, :login_path)

  plug :roles, storage: KeenAuth.Config.get_storage(), op: :and, roles: ["admin"], only: [:secret]

  def secret(conn, _params) do
    conn
    |> text("secret data")
  end
end
