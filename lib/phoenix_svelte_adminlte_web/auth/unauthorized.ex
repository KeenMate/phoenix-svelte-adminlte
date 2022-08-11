defmodule PhoenixSvelteAdminlteWeb.Auth.Unauthorized do
  use PhoenixSvelteAdminlteWeb, :controller

  def redirect_path(conn, redirect_to) do
    Routes.auth_path(conn, :new, :aad, redirect_to: redirect_to)
  end
end
