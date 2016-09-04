defmodule Currencies.Representations do
  @derive [Poison.Encoder]
  defstruct [:unicode_decimal, :html]
end