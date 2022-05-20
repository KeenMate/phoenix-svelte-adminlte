defmodule PhoenixSvelteAdminlteWeb.Jwt.AuthPlug do
  import Plug.Conn

  def init(default), do: default

  def call(%Plug.Conn{cookies: %{"accessToken" => at}} = conn, default) do
    IO.inspect(at)
    IO.inspect(conn)
    IO.inspect(default)
  end

  def call(_conn, _default) do
    Logger.error("not match")
  end
end
