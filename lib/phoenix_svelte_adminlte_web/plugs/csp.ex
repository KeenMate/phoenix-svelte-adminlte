defmodule PhoenixSvelteAdminlteWeb.CSP do
  @behaviour Plug

  import Plug.Conn

  @impl true
  def init(_opts) do
    policy()
    |> build_policy()
  end

  @impl true
  def call(conn, policy) do
    conn
    |> put_resp_header("content-security-policy", policy)
  end

  defp policy() do
    [
      "frame-ancestors 'self' matomo.web-03.km8.es"
    ]
  end

  defp build_policy(policy) do
    Enum.join(policy, ";")
  end
end
