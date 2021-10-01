import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_svelte_adminlte, PhoenixSvelteAdminlteWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "h4NdO21eR9T3p5XUlxCOx2H16gCzjjTSz6t8Dz0gormNb+Mz3DHFvQanIjYFhx1p",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
