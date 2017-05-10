Currencies [![Build Status](https://travis-ci.org/JakeStaTeresa/Currencies.svg?branch=master)](https://travis-ci.org/JakeStaTeresa/Currencies) [![Coverage Status](https://coveralls.io/repos/github/JakeStaTeresa/Currencies/badge.svg?branch=master&cache=2)](https://coveralls.io/github/JakeStaTeresa/Currencies) [![hex.pm version](https://img.shields.io/hexpm/v/currencies.svg)](https://hex.pm/packages/currencies) [![hex.pm downloads](https://img.shields.io/hexpm/dt/currencies.svg)](https://hex.pm/packages/currencies)
============

Currencies is a collection of all sorts of useful information for every currency in the ISO 4217 standard.

## Installation
Add `currencies` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:currencies, "~> 0.5.1"}]
end
```

After you are done, run `mix deps.get` in your shell to fetch and compile `Currencies`.

## Usage

Get all Currencies.

```Elixir
Countries.all |>
  Enum.count
# 162
```

Gets all currencies matching a currency code or iso numeric code

```Elixir
Currencies.all(["aud", :sgd, 51, %{}])
  |> Enum.map(fn(item) ->
      case item do
        :not_found -> :not_found
        item -> item.name
      end
    end)
# ["Australia Dollar",
#  "Singapore Dollar",
#  "Armenia Dram",
#  :not_found]
```

Find currency by code.

```Elixir
Countries.get("AUD") # Currencies.get(:aud) also supported
# %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
#   url: "http://www.rba.gov.au"}, code: "AUD", display: "$",
#  minor_unit: %Currencies.MinorUnit{name: "Cent", size: "1/100", symbol: "c"},
#  name: "Australia Dollar", nicknames: ["Buck", "Dough"],
#  representations: %Currencies.Representations{html: "&#36;",
#   unicode_decimal: '$'},
#  users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands", "Kiribati",
#   "Nauru", "Norfolk Island", "Ashmore and Cartier Islands",
#   "Australian Antarctic Territory", "Coral Sea Islands", "Heard Island",
#   "McDonald Islands"]}
```

Find currency by iso numeric code

```Elixir
Countries.get(36)
# %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Reserve Bank of Australia",
#   url: "http://www.rba.gov.au"}, code: "AUD", display: "$",
#  minor_unit: %Currencies.MinorUnit{name: "Cent", size: "1/100", symbol: "c"},
#  name: "Australia Dollar", nicknames: ["Buck", "Dough"],
#  representations: %Currencies.Representations{html: "&#36;",
#   unicode_decimal: '$'},
#  users: ["Australia", "Christmas Island", "Cocos (Keeling) Islands", "Kiribati",
#   "Nauru", "Norfolk Island", "Ashmore and Cartier Islands",
#   "Australian Antarctic Territory", "Coral Sea Islands", "Heard Island",
#   "McDonald Islands"]}
```

Find currency by filtering through the list of currencies.

```Elixir
Currencies.filter(&(String.contains?(&1.name, "Peso"))) |>
  Enum.map(&(&1.name))
# ["Argentina Peso", "Chile Peso", "Colombia Peso", "Cuba Convertible Peso", "Cuba Peso",
# "Dominican Republic Peso", "Mexico Peso", "Philippines Peso", "Uruguay Peso"]
```

```Elixir
Currencies.filter(&(String.contains?(&1.name, "Peso"))) |>
  Enum.map(&(&1.name)) |>
  Enum.count
# 9
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
