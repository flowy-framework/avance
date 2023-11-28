defmodule Avance.MixProject do
  use Mix.Project

  def project do
    [
      app: :avance,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Hex
      package: package(),

      # Docs
      name: "Avance",
      source_url: "",
      homepage_url: "",
      docs: [
        # The main page in the docs
        main: "Avance",
        extra_section: "GUIDES",
        extras: extras(),
        groups_for_extras: groups_for_extras()
      ]
    ]
  end

  defp extras do
    [
      "docs/guides/directory_structure.md"
    ]
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* CHANGELOG* LICENSE*)
    ]
  end

  defp groups_for_extras do
    [
      Guides: ~r/docs\/guides\/[^\/]+\.md/
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Avance.Application, []},
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
      {:phoenix, "~> 1.7.10"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.1"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.14"},
      {:finch, "~> 0.16"},
      {:gettext, "~> 0.23"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug_cowboy, "~> 2.5"},

      # flowy
      {:casex, git: "https://github.com/livesup-dev/casex", tag: "0.4.3"},

      # Opentelemetry
      {:opentelemetry_exporter, "~> 1.6.0"},
      {:opentelemetry, "~> 1.3.0"},
      {:opentelemetry_api, "~> 1.2.0"},
      {:opentelemetry_ecto, "~> 1.1.0"},
      {:opentelemetry_phoenix, "~> 1.1.0"},
      {:opentelemetry_liveview, "~> 1.0.0-rc.4"},
      {:logger_json, "~> 5.1"},

      # Monitoring
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:ecto_psql_extras, "~> 0.7"},

      # Security check
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: true},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},

      # Test coverage
      {:excoveralls, "~> 0.18", only: :test},

      # Testing tools
      {:faker, "~> 0.17", only: :test},
      {:bypass, "~> 2.1", only: :test},
      {:mock, "~> 0.3.0", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},

      # Docs
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:open_api_spex, "~> 3.16"},

      # Jobs
      {:oban, "~> 2.15"}
    ] ++
      private_deps()
  end

  def private_deps() do
    [
      {"../paleta", :paleta_dep},
      {"../flowy", :flowy_dep}
    ]
    |> Enum.map(fn {path, fun} ->
      apply(__MODULE__, fun, [File.exists?(path)])
    end)
    |> List.flatten()
  end

  def paleta_dep(true = _local) do
    [{:paleta, path: "../paleta", override: true}]
  end

  def paleta_dep(false) do
    [
      {:paleta, git: "https://github.com//flowy-framework/paleta", tag: "0.1.0"}
    ]
  end

  def flowy_dep(true = _local) do
    [{:flowy, path: "../flowy"}]
  end

  def flowy_dep(false) do
    [
      {:flowy, git: "https://github.com/flowy-framework/flowy", tag: "0.1.1"}
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
      setup: [
        "deps.get",
        "cmd npm install --prefix assets",
        "ecto.setup",
        "assets.setup",
        "assets.build"
      ],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.reset.db": ["ecto.drop", "ecto.create", "ecto.migrate"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
