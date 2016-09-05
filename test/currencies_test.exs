defmodule CurrenciesTest do
  use ExUnit.Case
  doctest Currencies

  test "all returns all currencies" do
    currencies = Currencies.all
    assert is_list(currencies)
    assert Enum.count(currencies) == 162
    assert Enum.at(currencies, 0, nil).__struct__ == Currencies.Currency
  end

  test "filter returns empty when no matches are found" do
    currencies = Currencies.filter(&(String.contains?(&1.code, "OmgWtfBbq")))
    assert is_list(currencies)
    assert Enum.count(currencies) == 0
  end

  test "filter returns some when matches are found" do
    currencies = Currencies.filter(&(String.contains?(&1.name, "Peso")))
    assert is_list(currencies)
    assert Enum.count(currencies) == 9
    assert Enum.at(currencies, 0, nil).__struct__ == Currencies.Currency
  end

  test "get returns not_found when currency code is not found" do
    assert Currencies.get("OMGWTFBBQ") == :not_found
  end

  test "get returns a currency with basic properties" do
    currency = Currencies.get("AMD")
    assert currency != nil
    assert currency.code == "AMD"
    assert currency.name == "Armenia Dram"
    assert currency.__struct__ == Currencies.Currency

    assert currency.minor_unit != nil
    assert currency.minor_unit.name == "Luma"
    assert currency.minor_unit.size == "1/100"
    assert currency.minor_unit.__struct__ == Currencies.MinorUnit

    assert currency.central_bank != nil
    assert currency.central_bank.name == "Central Bank of Armenia"
    assert currency.central_bank.url == "http://www.cba.am"
    assert currency.central_bank.__struct__ == Currencies.CentralBank

    assert is_list(currency.users)
    assert Enum.count(currency.users) == 1
    assert Enum.at(currency.users, 0, nil) == "Armenia"
  end

  test "get returns a currency with unicode display symbol and representations" do
    currency = Currencies.get("AZN")
    assert currency != nil
    assert currency.code == "AZN"
    assert currency.name == "Azerbaijan New Manat"
    assert currency.display == "ман"
    assert currency.__struct__ == Currencies.Currency

    assert currency.representations != nil
    assert currency.representations.html == "&#1084;&#1072;&#1085;"
    assert currency.representations.unicode_decimal == [1084, 1072, 1085]
    assert currency.representations.__struct__ == Currencies.Representations
  end

  test "get returns a currency with a complete minor unit" do
    currency = Currencies.get("USD")
    assert currency != nil
    assert currency.code == "USD"
    assert currency.name == "United States Dollar"
    assert currency.__struct__ == Currencies.Currency

    assert currency.minor_unit != nil
    assert currency.minor_unit.name == "Cent"
    assert currency.minor_unit.size == "1/100"
    assert currency.minor_unit.symbol == "¢"
    assert currency.minor_unit.__struct__ == Currencies.MinorUnit
  end

  test "get returns a currency with nicknames" do
    currency = Currencies.get("EUR")
    assert currency != nil
    assert currency.code == "EUR"
    assert currency.name == "Euro Member Countries"
    assert currency.__struct__ == Currencies.Currency

    assert is_list(currency.nicknames)
    assert Enum.count(currency.nicknames) == 4
    assert currency.nicknames == ["Ege (Finnish)",
                                  "Leru (Spanish)",
                                  "Yoyo (Irish English)",
                                  "Teuro (German)"]
  end

  test "get returns a currency used in different places" do
    currency = Currencies.get("USD")
    assert currency != nil
    assert currency.code == "USD"
    assert currency.name == "United States Dollar"
    assert currency.__struct__ == Currencies.Currency

    assert is_list(currency.users)
    assert Enum.count(currency.users) == 19
    assert currency.users == ["United States",
                              "America",
                              "American Samoa",
                              "American Virgin Islands",
                              "British Indian Ocean Territory",
                              "British Virgin Islands",
                              "Ecuador",
                              "El Salvador",
                              "Guam",
                              "Haiti",
                              "Micronesia",
                              "Northern Mariana Islands",
                              "Palau",
                              "Panama",
                              "Puerto Rico",
                              "Turks and Caicos Islands",
                              "United States Minor Outlying Islands",
                              "Wake Island",
                              "East Timor"]
  end
end
