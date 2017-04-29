defmodule CurrenciesTest do
  use ExUnit.Case
  doctest Currencies

  test "all returns all currencies" do
    currencies = Currencies.all
    assert is_list(currencies)
    assert Enum.count(currencies) == 162
    assert Enum.at(currencies, 0, nil).__struct__ == Currencies.Currency
  end

  test "all accepts a list of currency codes or iso numeric codes and a list of currencies or :not_found" do
    currencies = Currencies.all(["aud", :sgd, 51, %{}])
      |> Enum.map(fn(item) ->
          case item do
            :not_found -> :not_found
            item -> item.name
          end
        end)
    assert Enum.count(currencies) == 4
    assert currencies == ["Australia Dollar",
                          "Singapore Dollar",
                          "Armenia Dram",
                          :not_found]
  end

  test "filter returns empty when no matches are found" do
    currencies = Currencies.filter(&(String.contains?(&1.code, "OmgWtfBbq")))
    assert is_list(currencies)
    assert Enum.count(currencies) == 0
  end

  test "filter returns empty when empty list is passed" do
    currencies = Currencies.filter([])
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
    assert currency.iso_numeric == "051"
    assert currency.__struct__ == Currencies.Currency

    assert currency.minor_unit != nil
    assert currency.minor_unit.name == "Luma"
    assert currency.minor_unit.size_to_unit == 100
    assert currency.minor_unit.display == "1/100"
    assert currency.minor_unit.__struct__ == Currencies.MinorUnit

    assert currency.central_bank != nil
    assert currency.central_bank.name == "Central Bank of Armenia"
    assert currency.central_bank.url == "http://www.cba.am"
    assert currency.central_bank.__struct__ == Currencies.CentralBank

    assert is_list(currency.users)
    assert Enum.count(currency.users) == 1
    assert Enum.at(currency.users, 0, nil) == "Armenia"

    assert is_list(currency.alternate_symbols)
    assert Enum.count(currency.alternate_symbols) == 1
    assert Enum.at(currency.alternate_symbols, 0, nil) == "dram"
  end

  test "get returns a currency with basic properties using iso numeric code" do
    currency = Currencies.get(51)
    assert currency != nil
    assert currency.code == "AMD"
    assert currency.name == "Armenia Dram"
    assert currency.iso_numeric == "051"
    assert currency.__struct__ == Currencies.Currency

    assert currency.minor_unit != nil
    assert currency.minor_unit.name == "Luma"
    assert currency.minor_unit.size_to_unit == 100
    assert currency.minor_unit.display == "1/100"
    assert currency.minor_unit.__struct__ == Currencies.MinorUnit

    assert currency.central_bank != nil
    assert currency.central_bank.name == "Central Bank of Armenia"
    assert currency.central_bank.url == "http://www.cba.am"
    assert currency.central_bank.__struct__ == Currencies.CentralBank

    assert is_list(currency.users)
    assert Enum.count(currency.users) == 1
    assert Enum.at(currency.users, 0, nil) == "Armenia"

    assert is_list(currency.alternate_symbols)
    assert Enum.count(currency.alternate_symbols) == 1
    assert Enum.at(currency.alternate_symbols, 0, nil) == "dram"
  end

  test "get returns a currency with basic properties using symbol" do
    currency = Currencies.get(:amd)
    assert currency != nil
    assert currency.code == "AMD"
    assert currency.name == "Armenia Dram"
    assert currency.iso_numeric == "051"
    assert currency.__struct__ == Currencies.Currency

    assert currency.minor_unit != nil
    assert currency.minor_unit.name == "Luma"
    assert currency.minor_unit.size_to_unit == 100
    assert currency.minor_unit.display == "1/100"
    assert currency.minor_unit.__struct__ == Currencies.MinorUnit

    assert currency.central_bank != nil
    assert currency.central_bank.name == "Central Bank of Armenia"
    assert currency.central_bank.url == "http://www.cba.am"
    assert currency.central_bank.__struct__ == Currencies.CentralBank

    assert is_list(currency.users)
    assert Enum.count(currency.users) == 1
    assert Enum.at(currency.users, 0, nil) == "Armenia"

    assert is_list(currency.alternate_symbols)
    assert Enum.count(currency.alternate_symbols) == 1
    assert Enum.at(currency.alternate_symbols, 0, nil) == "dram"
  end

  test "get returns a currency with unicode display symbol and representations" do
    currency = Currencies.get("AZN")
    assert currency != nil
    assert currency.code == "AZN"
    assert currency.name == "Azerbaijan New Manat"
    assert currency.symbol == "ман"
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
    assert currency.minor_unit.size_to_unit == 100
    assert currency.minor_unit.display == "1/100"
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

  test "central_bank returns the name of the central bank governing the currency" do
    central_bank = Currencies.central_bank("USD")
    assert central_bank != nil
    assert central_bank.name == "Federal Reserve Bank"
    assert central_bank.url == "http://www.federalreserve.gov"
    assert central_bank.__struct__ == Currencies.CentralBank
  end

  test "central_bank returns :not_found if currency code does not exist" do
    central_bank = Currencies.central_bank("OMG")
    assert central_bank == :not_found
  end

  test "central_bank returns :not_found if central_bank does not exist for currency code" do
    central_bank = Currencies.central_bank("FJD")
    assert central_bank == :not_found
  end

  test "minor_unit returns the minor_unit details of the currency" do
    minor_unit = Currencies.minor_unit("USD")
    assert minor_unit != nil
    assert minor_unit.name == "Cent"
    assert minor_unit.display == "1/100"
    assert minor_unit.size_to_unit == 100
    assert minor_unit.symbol == "¢"
    assert minor_unit.__struct__ == Currencies.MinorUnit
  end

  test "minor_unit returns :not_found if currency code does not exist" do
    minor_unit = Currencies.minor_unit("OMG")
    assert minor_unit == :not_found
  end

  test "minor_unit returns :not_found if minor_unit does not exist for currency code" do
    minor_unit = Currencies.minor_unit("VUV")
    assert minor_unit == :not_found
  end

end
