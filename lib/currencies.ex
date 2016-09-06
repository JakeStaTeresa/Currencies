defmodule Currencies do
  @moduledoc """
  Specialized functions that return Currencies.
  """

  # Pre-loads currency data at compile time
  @currencies Path.join("data", "currencies.bin") |>
    Path.expand(__DIR__) |>
    File.read! |>
    :erlang.binary_to_term

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
  Returns a single currency given its currency code

  ## Examples
    iex> Currencies.get("AUD")
    %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
    url: "http://www.rba.gov.au"}, code: "AUD", display: "$",
    minor_unit: %Currencies.MinorUnit{name: "Cent", size: "1/100", symbol: "c"},
    name: "Australia Dollar", nicknames: ["Buck", "Dough"],
    representations: %Currencies.Representations{html: "&#36;",
    unicode_decimal: '$'},
    users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands", "Kiribati",
    "Nauru", "Norfolk Island", "Ashmore and Cartier Islands",
    "Australian Antarctic Territory", "Coral Sea Islands", "Heard Island",
    "McDonald Islands"]}
  """
  def get(currency_code) when is_binary(currency_code) do
      filter(&(String.downcase(&1.code) == String.downcase(currency_code))) |>
        Enum.at(0, :not_found)
  end
end