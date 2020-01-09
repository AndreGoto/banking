defmodule Banking.MixProject do
  use Mix.Project

  def project do
    [
      app: :banking,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Banking.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "3.3.2"},
      {:postgrex, "0.15.3"},
      {:comeonin, "~> 4.1"},
      {:pbkdf2_elixir, "~> 0.12"}
    ]
  end
end
