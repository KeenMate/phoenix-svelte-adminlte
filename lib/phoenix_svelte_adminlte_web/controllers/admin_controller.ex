defmodule PhoenixSvelteAdminlteWeb.AdminController do
  use PhoenixSvelteAdminlteWeb, :controller

  alias KeenAuth.Plug.Authorize
  alias KeenAuth.Plug.RequireAuthenticated

  plug RequireAuthenticated

  plug Authorize.Roles, op: :and, roles: ["admin"], only: [:secret]

  def secret(conn, _params) do
    conn
    |> text("secret data")
  end
end
