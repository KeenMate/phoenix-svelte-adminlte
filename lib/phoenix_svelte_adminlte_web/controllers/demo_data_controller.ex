defmodule PhoenixSvelteAdminlteWeb.DemoDataController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  def tree_inital_data(conn, _params) do
    data =
      PhoenixSvelteAdminlte.Tree.get_init_tree()
      |> PhoenixSvelteAdminlte.MapHelpers.camel_cased_map_keys()
      |> Enum.map(fn a ->
        a |> Map.from_struct() |> PhoenixSvelteAdminlte.MapHelpers.camel_cased_map_keys()
      end)

      PhoenixSvelteAdminlteWeb.ConnHelper.success_response(conn,data)
  end
end
