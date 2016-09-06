defmodule Currencies do
  @moduledoc """
  Specialized functions that return Currencies.
  """

  alias Currencies.Currency
  alias Currencies.CentralBank
  alias Currencies.Representations
  alias Currencies.MinorUnit

  # Pre-loads currency data at compile time
  data_path = fn (path) ->
    Path.join("data", path) |> Path.expand(__DIR__)
  end

  load_currency = fn(currency_code) ->
      data_path.(Path.join("currencies", String.downcase(currency_code) <> ".json")) |>
      File.read! |>
      Poison.decode!(as: %Currency{representations: %Representations{}, minor_unit: %MinorUnit{}, central_bank: %CentralBank{}})
  end

  @currencies data_path.("currencies.json") |>
      File.read! |>
      Poison.decode!(as: [ %Currency{} ]) |>
      Enum.map(&(load_currency.(&1.code)))

  @doc """
  Returns all currencies matching the given predicate

  ## Examples

    iex> Currencies.filter(&(String.contains?(&1.name, "Peso"))) |> Enum.map(&(&1.name))
    ["Argentina Peso",
    "Chile Peso",
    "Colombia Peso",
    "Cuba Convertible Peso",
    "Cuba Peso",
    "Dominican Republic Peso",
    "Mexico Peso",
    "Philippines Peso",
    "Uruguay Peso"]

  """
  def filter(predicate) when is_function(predicate, 1) do
    all |>
      Enum.filter(predicate)
  end

  @doc """
  Returns all currencies

  ## Examples
    iex> Currencies.all |> Enum.count
    162
  """
  def all do
    @currencies
  end

  @doc """
  Returns a single currency given its currency code as a symbol

  ## Examples
    iex> Currencies.get(:aud)
    %Currencies.Currency{alternate_symbols: ["A$"],
    central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
    url: "http://www.rba.gov.au"}, code: "AUD",
    disambiguate_symbol: "A$", iso_numeric: "036",
    minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Cent",
    size_to_unit: 100, symbol: "c"}, name: "Australia Dollar",
    nicknames: ["Buck", "Dough"],
    representations: %Currencies.Representations{html: "&#36;",
    unicode_decimal: '$'}, symbol: "$",
    users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands",
    "Kiribati", "Nauru", "Norfolk Island",
    "Ashmore and Cartier Islands", "Australian Antarctic Territory",
    "Coral Sea Islands", "Heard Island", "McDonald Islands"]}
  """
  def get(currency_code) when is_atom(currency_code) do
   currency_code |> Atom.to_string
    |> get
  end

  @doc """
  Returns a single currency given its currency code

  ## Examples
    iex> Currencies.get("AUD")
    %Currencies.Currency{alternate_symbols: ["A$"],
    central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
    url: "http://www.rba.gov.au"}, code: "AUD",
    disambiguate_symbol: "A$", iso_numeric: "036",
    minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Cent",
    size_to_unit: 100, symbol: "c"}, name: "Australia Dollar",
    nicknames: ["Buck", "Dough"],
    representations: %Currencies.Representations{html: "&#36;",
    unicode_decimal: '$'}, symbol: "$",
    users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands",
    "Kiribati", "Nauru", "Norfolk Island",
    "Ashmore and Cartier Islands", "Australian Antarctic Territory",
    "Coral Sea Islands", "Heard Island", "McDonald Islands"]}
  """
  def get(currency_code) when is_binary(currency_code) do
      filter(&(String.downcase(&1.code) == String.downcase(currency_code))) |>
        Enum.at(0, :not_found)
  end

end