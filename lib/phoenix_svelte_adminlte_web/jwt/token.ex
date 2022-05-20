defmodule Token do
  # no signer
  use Joken.Config

  require Logger

  # This hook implements a before_verify callback that checks whether it has a signer configuration
  # cached. If it does not, it tries to fetch it from the jwks_url.
  add_hook(JokenJwks,
    strategy: PhoenixSvelteAdminlteWeb.Jwt.MicrosoftStrategy
  )

  @impl true
  def token_config do
    Logger.warn("I am inside token config")

    default_claims(skip: [:aud, :iss])
    # |> add_claim("roles", nil, &(&1 in ["admin", "user"]))
    # |> add_claim("iss", nil, &(&1 == "some server iss"))
    # |> add_claim("aud", nil, &(&1 == "some server aud"))
  end
end
