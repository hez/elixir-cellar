defmodule Cellar.MixProject do
  use Mix.Project

  @version "0.1.2"

  def project do
    [
      app: :cellar,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        plt_add_deps: :transitive,
        plt_add_apps: [:mix],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Cellar.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Test and Dev
      {:credo, "~> 1.3.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.4", only: :dev, runtime: false},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # All
      {:csv, "~> 2.3.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
