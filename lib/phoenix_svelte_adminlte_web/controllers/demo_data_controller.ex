defmodule PhoenixSvelteAdminlteWeb.DemoDataController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  def tree_inital_data(conn, _params) do
    data =
      PhoenixSvelteAdminlte.Tree.get_init_tree()
      |> PhoenixSvelteAdminlte.MapHelpers.camelize_array()

    PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, data)
  end

  def test(conn, _params) do
    conn = Plug.Conn.fetch_cookies(conn)

    IO.inspect(conn.cookies)

    IO.inspect(PhoenixSvelteAdminlteWeb.Jwt.MicrosoftStrategy.EtsCache.get_signers())

    case Token.verify(conn.cookies["accessToken"]) do
      {:error, res} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.error_response(conn, msg: Atom.to_string(res))

      {:ok, res} ->
        PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn, res)
    end
  end
end
