use Mix.Config

config :Banking, Banking.Repo,
  database: "banking",
  username: "postgres",
  password: "postgres",
  hostname: "postgres",
  port: "5432"
