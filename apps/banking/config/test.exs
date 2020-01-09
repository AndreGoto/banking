use Mix.Config

config :banking, Banking.Repo,
  username: "postgres",
  password: "postgres",
  database: "banking_test",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info


