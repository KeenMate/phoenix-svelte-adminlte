defmodule PhoenixSvelteAdminlteWeb.ConnHelper do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  def success(data \\ nil, metadata \\ nil) do
    %{data: data, metadata: metadata}
  end

  def success_response(conn, data \\ nil, metadata \\ nil) do
    conn
    |> put_status(200)
    |> json(success(data, metadata))
  end

  def error(opts \\ []) do
    %{error: %{code: Keyword.get(opts, :reason), msg: Keyword.get(opts, :msg), detail: Keyword.get(opts, :detail)}, metadata: Keyword.get(opts, :metadata)}
  end

  def error_response(conn, opts \\ []) do
    conn
    |> put_status(Keyword.get(opts, :response_code, 500))
    |> json(error(opts))
  end
end
