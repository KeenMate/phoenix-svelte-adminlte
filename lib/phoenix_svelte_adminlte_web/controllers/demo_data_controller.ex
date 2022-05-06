defmodule PhoenixSvelteAdminlteWeb.DemoDataController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  def tree_inital_data(conn, _params) do
    data =
      PhoenixSvelteAdminlte.Tree.get_init_tree()
      |> PhoenixSvelteAdminlte.MapHelpers.camelize_array()

      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn,data)
  end
end
