# Currencies
[![Build Status](https://travis-ci.org/JakeStaTeresa/Currencies.svg?branch=master)](https://travis-ci.org/JakeStaTeresa)
============

Currencies is a collection of all sorts of useful information for every currency in the ISO 4217 standard.

## Installation
Add `currencies` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:currencies, "~> 0.1.0"}]
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

Find currency by code.

```Elixir
Countries.get("AUD")
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
Currencies.filter(&(String.contains?(&1.name, "Peso")))
# [%Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of Argentina",
#    url: "http://www.bcra.gov.ar/index_i.htm"}, code: "ARS", display: "$",
#   minor_unit: %Currencies.MinorUnit{name: "Centavo", size: "1/100",
#    symbol: nil}, name: "Argentina Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#36;",
#    unicode_decimal: '$'}, users: ["Argentina", "Islas Malvinas"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Banco Central De Chile",
#    url: "http://www.bcentral.cl/eng/"}, code: "CLP", display: "$",
#   minor_unit: %Currencies.MinorUnit{name: "Centavo", size: "1/100",
#    symbol: nil}, name: "Chile Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#36;",
#    unicode_decimal: '$'}, users: ["Chile"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of Colombia",
#    url: "http://www.banrep.gov.co"}, code: "COP", display: "$",
#   minor_unit: %Currencies.MinorUnit{name: "Centavo", size: "1/100",
#    symbol: nil}, name: "Colombia Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#36;",
#    unicode_decimal: '$'}, users: ["Colombia"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of Cuba",
#    url: "http://www.bc.gob.cu/Espanol/default.asp"}, code: "CUC", display: nil,
#   minor_unit: %Currencies.MinorUnit{name: "Centavo Convertible", size: "1/100",
#    symbol: "¢"}, name: "Cuba Convertible Peso", nicknames: ["Chavito"],
#   representations: %Currencies.Representations{html: nil, unicode_decimal: nil},
#   users: ["Cuba"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "",
#    url: "http://www.bc.gob.cu/Espanol/default.asp"}, code: "CUP",
#   display: "₱",
#   minor_unit: %Currencies.MinorUnit{name: "Centavo", size: "1/100",
#    symbol: "¢"}, name: "Cuba Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#8369;",
#    unicode_decimal: [8369]}, users: ["Cuba"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of the Dominican Republic",
#    url: "http://www.bancentral.gov.do"}, code: "DOP", display: "RD$",
#   minor_unit: %Currencies.MinorUnit{name: "Centavo", size: "1/100",
#    symbol: nil}, name: "Dominican Republic Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#82;&#68;&#36;",
#    unicode_decimal: 'RD$'}, users: ["Dominican Republic"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Bank of Mexico",
#    url: "http://www.banxico.org.mx"}, code: "MXN", display: "$",
#   minor_unit: %Currencies.MinorUnit{name: "Cent", size: "1/100", symbol: nil},
#   name: "Mexico Peso",
#   nicknames: ["lana", "varos", "plata", "bolas", "lucas", "feria", "billete",
#    "pachocha", "billullos", "villancicos", "villanos", "del águila",
#    "morlacos", "papiros", "Marmaja"],
#   representations: %Currencies.Representations{html: "&#36;",
#    unicode_decimal: '$'}, users: ["Mexico"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of the Philippines",
#    url: "http://www.bsp.gov.ph/"}, code: "PHP", display: "₱",
#   minor_unit: %Currencies.MinorUnit{name: "Sentimo", size: "1/100",
#    symbol: nil}, name: "Philippines Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#8369;",
#    unicode_decimal: [8369]}, users: ["Philippines"]},
#  %Currencies.Currency{central_bank: %Currencies.CentralBank{name: "Central Bank of Uruguay",
#    url: "http://www.bcu.gub.uy"}, code: "UYU", display: "$U",
#   minor_unit: %Currencies.MinorUnit{name: "Centésimo", size: "1/100",
#    symbol: nil}, name: "Uruguay Peso", nicknames: nil,
#   representations: %Currencies.Representations{html: "&#36;&#85;",
#    unicode_decimal: '$U'}, users: ["Uruguay"]}]

Currencies.filter(&(String.contains?(&1.name, "Peso"))) |>
  Enum.map(&(&1.name))
# ["Argentina Peso", "Chile Peso", "Colombia Peso", "Cuba Convertible Peso",
#  "Cuba Peso", "Dominican Republic Peso", "Mexico Peso", "Philippines Peso",
#  "Uruguay Peso"]

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
