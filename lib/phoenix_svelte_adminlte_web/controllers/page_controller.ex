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

  def me(conn, _params) do
    user = KeenAuth.Storage.current_user(conn)

    map = case user do
      nil -> %{}
      user -> Map.from_struct(user)
    end

    json(conn, map)
  end
end
