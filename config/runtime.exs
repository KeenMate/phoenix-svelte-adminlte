import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  config :logger,
    level: System.fetch_env!("LOG_LEVEL") |> String.downcase() |> String.to_existing_atom()

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :phoenix_svelte_adminlte, PhoenixSvelteAdminlteWeb.Endpoint,
    server: true,
    url: [scheme: "https", host: System.fetch_env!("HOST"), port: 443],
    http: [
      :inet6,
      port: String.to_integer(System.get_env("PORT") || "4000"),
      compress: true
    ],
    secret_key_base: secret_key_base

  config :keen_auth,
    strategies: [
      aad: [
        config: [
          tenant_id: System.fetch_env!("AAD_TENANT_ID"),
          client_id: System.fetch_env!("AAD_CLIENT_ID"),
          client_secret: System.fetch_env!("AAD_CLIENT_SECRET"),
        ]
      ]
    ]


  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :phoenix_svelte_adminlte, PhoenixSvelteAdminlteWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.
end
