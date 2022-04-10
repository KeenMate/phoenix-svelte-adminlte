defmodule PhoenixSvelteAdminlteWeb.DemoDataController do
  use PhoenixSvelteAdminlteWeb, :controller

  def tree_inital_data(conn, _params) do
    conn |> json( PhoenixSvelteAdminlte.Tree.get_init_tree )
  end
end
