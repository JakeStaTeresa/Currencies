defmodule Currencies.Mixfile do
  use Mix.Project

  def project do
    [app: :currencies,
     version: "0.3.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package,
     docs: [extras: ["README.md"]],
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:poison, "~> 2.0", only: [:dev, :test]},
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.5", only: :test}]
  end

  defp description do
    """
    Currencies is a collection of all sorts of useful information for every currency in the ISO 4217 standard.
    """
  end

  def package do
    [ name: :currencies,
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Kriztian Jake Sta. Teresa"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/JakeStaTeresa/Currencies"},
    ]
  end
end