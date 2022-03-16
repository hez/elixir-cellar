defmodule Cellar.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :cellar,
      version: @version,
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      aliases: aliases(),
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
      # dev
      {:credo, "~> 1.6.0", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.30.0", only: :test},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # everything
      {:csv, "~> 2.4.1"},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:phoenix, "~> 1.6.6"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:plug_cowboy, "~> 2.5"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end
