defmodule Currencies.Currency do
  @moduledoc """
  A struct that keeps information about the currency.

  It contains the following fields:
   * `:code` - the currency code
   * `:name` - the name of the curency
   * `:display` - the displayable currency symbol
   * `:representations` - contains html and unicode decimal representations for the currency symbol
   * `:minor_unit` - contains sub-init or minor unit information about the currency
   * `:central_bank` - contains information about the central bank governing the currency
   * `:nicknames` - contains nicknames for the currency
   * `:users` - contains places or countries using the currency
  """

  defstruct [:code, :name, :symbol, :iso_numeric, :disambiguate_symbol, :alternate_symbols, :representations, :minor_unit, :central_bank, :nicknames, :users]

  @type t :: %__MODULE__{
            code: String.t,
            name: String.t,
            symbol: String.t,
            iso_numeric: String.t,
            disambiguate_symbol: String.t,
            alternate_symbols: [String.t],
            representations: Currencies.Representations.t,
            minor_unit: Currencies.MinorUnit.t,
            central_bank: Currencies.CentralBank.t,
            nicknames: [String.t],
            users: [String.t]
          }
end