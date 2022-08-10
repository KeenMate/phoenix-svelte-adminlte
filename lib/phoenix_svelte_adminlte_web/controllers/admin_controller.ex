defmodule PhoenixSvelteAdminlteWeb.AdminController do
  use PhoenixSvelteAdminlteWeb, :controller

  alias KeenAuth.Plug.Authorize
  alias KeenAuth.Plug.RequireAuthenticated

  import Authorize

  plug RequireAuthenticated, storage: KeenAuth.Config.get_storage(), login_path: &PhoenixSvelteAdminlteWeb.AdminController.login_path/2

  plug :roles, storage: KeenAuth.Config.get_storage(), op: :and, roles: ["admin"], only: [:secret]

  def login_path(conn, redirect_to) do
    Routes.auth_path(conn, :new, :aad, redirect_to: redirect_to)
  end

  def secret(conn, _params) do
    conn
    |> text("secret data")
  end
end
