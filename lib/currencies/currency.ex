defmodule Currencies.Currency do
  @derive [Poison.Encoder]
  defstruct [:code, :name, :display, :representations, :minor_unit, :central_bank, :nicknames, :users]
end