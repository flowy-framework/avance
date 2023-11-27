import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :avance, Avance.Repo,
  username: System.get_env("DBUSER") || "postgres",
  password: System.get_env("DBPASSWORD") || "postgres",
  hostname: System.get_env("DBHOST") || "localhost",
  database: "avance_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :avance, AvanceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Mzf8ab/lhvGqzSra84a/elmzhJ0gFq8iIV5Fe1qeHHU9+IdbA8AKTyl49Nd5BOky",
  server: false

# In test we don't send emails.
config :avance, Avance.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :avance, Oban, testing: :inline
