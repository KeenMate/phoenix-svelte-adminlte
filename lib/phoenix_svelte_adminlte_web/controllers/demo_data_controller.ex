defmodule PhoenixSvelteAdminlteWeb.DemoDataController do
  use PhoenixSvelteAdminlteWeb, :controller
  require Logger

  def tree_inital_data(conn, _params) do
    Logger.info(inspect(PhoenixSvelteAdminlte.Tree.get_init_tree()))
    conn |> json(PhoenixSvelteAdminlte.Tree.get_init_tree())
  end
end
