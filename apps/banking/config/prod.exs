use Mix.Config

config :Banking, Banking.Repo,
  database: "banking",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"
