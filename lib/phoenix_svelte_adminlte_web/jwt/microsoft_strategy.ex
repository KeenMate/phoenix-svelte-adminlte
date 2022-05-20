defmodule PhoenixSvelteAdminlteWeb.Jwt.MicrosoftStrategy do
  use JokenJwks.DefaultStrategyTemplate

  def init_opts(opts) do
    Logger.info("init strategy")

    microsoft_opts = [
      jwks_url:
        "https://login.microsoftonline.com/6ee623a2-0b05-4ea4-b931-79c555955cb1/discovery/v2.0/keys?appid=f1b31a4f-f065-4b87-a9a9-eb802130c87d",
      http_adapter: Tesla.Adapter.Hackney,
      first_fetch_sync: true,
      explicit_alg: "RS256"
    ]

    Keyword.merge(opts, microsoft_opts)
  end
end
