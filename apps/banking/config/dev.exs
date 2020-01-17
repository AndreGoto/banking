use Mix.Config

config :banking, Banking.Repo,
  username: "postgres",
  password: "postgres",
  database: "banking_dev",
  hostname: "postgres",
  port: "5432"

config :logger, level: :info
