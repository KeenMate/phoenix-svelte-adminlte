defmodule PhoenixSvelteAdminlteWeb.PageController do
  use PhoenixSvelteAdminlteWeb, :controller

  def index(conn, _params) do
    page =
      Application.get_application(__MODULE__)
      |> :code.priv_dir()
      |> Path.join("static/index.html")
      |> File.read!()

    html(conn, page)
  end
end
