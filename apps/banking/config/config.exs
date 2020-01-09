use Mix.Config

config :banking, ecto_repos: [Banking.Repo]

import_config "#{Mix.env()}.exs"

