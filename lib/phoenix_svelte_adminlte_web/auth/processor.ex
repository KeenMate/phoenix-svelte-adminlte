defmodule PhoenixSvelteAdminlteWeb.Auth.Processor do
  @behaviour KeenAuth.Processor

  import Plug.Conn, only: [put_session: 3]

  require Logger

  @impl true
  def process(conn, provider, mapped_user, response) do
    Logger.debug("Processing OAuth response for #{provider}", response: inspect(response))

    {:ok, put_session(conn, :oauth_response, response), mapped_user, response}
  end
end
