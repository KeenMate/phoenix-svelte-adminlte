import Config

config :logger, :console,
  format: "[$level] $message $metadata\n",
  metadata: [
    :module,
    :request_id,
    :remote_ip,
    :error,
    :reason,
    :response,
    :application,
    :file,
    :line,
    :register_name,
    :crash_reason
  ]
