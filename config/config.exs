# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phoenix_svelte_adminlte,
  ecto_repos: [PhoenixSvelteAdminlte.Repo]

# Configures the endpoint
config :phoenix_svelte_adminlte, PhoenixSvelteAdminlteWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PhoenixSvelteAdminlteWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixSvelteAdminlte.PubSub,
  live_view: [signing_salt: "nmhtFBNj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [
    :module,
    :request_id,
    :remote_ip,
    :error,
    :reason,
    :detail,
    :response,
    :body,
    :application,
    :file,
    :line,
    :register_name,
    :crash_reason
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix_svelte_adminlte, :keen_auth,
  unauthorized_redirect: &PhoenixSvelteAdminlteWeb.Auth.Unauthorized.redirect_path/2,
  db_context: PhoenixSvelteAdminlte.Database.DbContext,
  tenant: 1,
  strategies: [
    aad: [
      strategy: Assent.Strategy.AzureAD,
      mapper: KeenAuth.Mapper.AzureAD,
      processor: KeenAuthPermissions.Processor.AzureAD
    ],
    email: [
      mapper: KeenAuthPermissions.Mapper.Email,
      processor: KeenAuthPermissions.Processor.Email,
      authentication_handler: PhoenixSvelteAdminlteWeb.Auth.EmailAuthenticationHandler
    ]
  ]

config :keen_auth,
  email_enabled: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

File.regular?("config/.local.exs") && import_config(".local.exs")
