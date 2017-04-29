defmodule Currencies do
  @moduledoc """
  Specialized functions that return Currencies.
  """

  alias Currencies.Currency
  alias Currencies.CentralBank
  alias Currencies.Representations
  alias Currencies.MinorUnit

  # Pre-loads currency data at compile time
  if Code.ensure_compiled(Poison) do
    data_path = fn (path) ->
      Path.join("data", path) |> Path.expand(__DIR__)
    end

    load_currency = fn(currency_code) ->
        data_path.(Path.join("currencies", String.downcase(currency_code) <> ".json"))
          |> File.read!
          |> Poison.decode!(as: %Currency{representations: %Representations{}, minor_unit: %MinorUnit{}, central_bank: %CentralBank{}})
    end

    @currencies data_path.("currencies.json")
      |> File.read!
      |> Poison.decode!(as: [ %Currency{} ])
      |> Enum.map(&(load_currency.(&1.code)))
  end
  @doc """
  Returns all currencies matching the given predicate

  ## Examples

      iex> Currencies.filter(&(String.contains?(&1.name, "Peso")))
      ...>   |> Enum.map(&(&1.name))
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
  def filter([]), do: []
  def filter(predicate) when is_function(predicate, 1) do
    all() |> Enum.filter(predicate)
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
  Returns all currencies whose currency codes or integer iso numeric code matches the items in the list
  Returns :not_found if the a currency with the given currency code or iso numeric code can not be found.

  ## Examples
      iex> Currencies.all(["aud", :sgd, 51, %{}])
      [%Currencies.Currency{alternate_symbols: ["A$"],
      central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
      url: "http://www.rba.gov.au"}, code: "AUD", disambiguate_symbol: "A$",
      iso_numeric: "036",
      minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Cent",
      size_to_unit: 100, symbol: "c"}, name: "Australia Dollar",
      nicknames: ["Buck", "Dough"],
      representations: %Currencies.Representations{html: "&#36;",
      unicode_decimal: '$'}, symbol: "$",
      users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands",
      "Kiribati", "Nauru", "Norfolk Island", "Ashmore and Cartier Islands",
      "Australian Antarctic Territory", "Coral Sea Islands", "Heard Island",
      "McDonald Islands"]},
      %Currencies.Currency{alternate_symbols: ["S$"],
      central_bank: %Currencies.CentralBank{name: "Monetary Authority of Singapore",
      url: "http://www.mas.gov.sg"}, code: "SGD", disambiguate_symbol: "S$",
      iso_numeric: "702",
      minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Cent",
      size_to_unit: 100, symbol: "S¢"}, name: "Singapore Dollar",
      nicknames: ["Sing"],
      representations: %Currencies.Representations{html: "&#36;",
      unicode_decimal: '$'}, symbol: "$", users: ["Singapore"]},
      %Currencies.Currency{alternate_symbols: ["dram"],
      central_bank: %Currencies.CentralBank{name: "Central Bank of Armenia",
      url: "http://www.cba.am"}, code: "AMD", disambiguate_symbol: nil,
      iso_numeric: "051",
      minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Luma",
      size_to_unit: 100, symbol: nil}, name: "Armenia Dram", nicknames: nil,
      representations: %Currencies.Representations{html: nil, unicode_decimal: nil},
      symbol: nil, users: ["Armenia"]}, :not_found]
  """
  def all(currency_codes_or_iso_numeric_codes) when is_list(currency_codes_or_iso_numeric_codes) do
    currency_codes_or_iso_numeric_codes
    |> Enum.dedup
    |> Enum.map(&get/1)
  end

  @doc """
  Returns a single currency given given its currency code or iso numeric code
  Returns :not_found if the a currency with the given currency code can not be found.

  # Get currency given its currency code as a symbol
      iex> Currencies.get(:aud)
      %Currencies.Currency{alternate_symbols: ["A$"],
      central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
      url: "http://www.rba.gov.au"}, code: "AUD",
      disambiguate_symbol: "A$", iso_numeric: "036",
      minor_unit: %Currencies.MinorUnit{display: "1/100", name: "Cent",
      size_to_unit: 100, symbol: "c"}, name: "Australia Dollar",
      nicknames: ["Buck", "Dough"],
      representations: %Currencies.Representations{html: "&#36;",
      unicode_decimal: [36]}, symbol: "$",
      users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands",
      "Kiribati", "Nauru", "Norfolk Island",
      "Ashmore and Cartier Islands", "Australian Antarctic Territory",
      "Coral Sea Islands", "Heard Island", "McDonald Islands"]}

  ## Get currency given its currency code as a string/binary
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

  ## Get currency given its iso numeric code as an integer
      iex> Currencies.get(36)
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

  ## Try to get a currency using an unsupported type
      iex> Currencies.get(%{})
      :not_found
  """
  def get(currency_code) when is_atom(currency_code) do
   currency_code
    |> Atom.to_string
    |> get
  end
  def get(currency_code) when is_binary(currency_code) do
      filter(&(String.downcase(&1.code) === String.downcase(currency_code)))
        |> Enum.at(0, :not_found)
  end
  def get(iso_numeric) when is_integer(iso_numeric) do
      filter(&(String.to_integer(&1.iso_numeric||"-101") === iso_numeric))
        |> Enum.at(0, :not_found)
  end
  def get(_param) do
    :not_found
  end

  def minor_unit(currency_code) do
    currency = get(currency_code)

    case currency do
      :not_found -> :not_found
      _ ->
        case currency.minor_unit do
          nil -> :not_found
          minor_unit -> minor_unit
        end
    end
  end

  def central_bank(currency_code) do
    currency = get(currency_code)

    case currency do
      :not_found -> :not_found
      _ ->
        case currency.central_bank do
          nil -> :not_found
          central_bank -> central_bank
        end
    end
  end

end
