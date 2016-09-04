defmodule Currencies.MinorUnit do
  @derive [Poison.Encoder]
  defstruct [:name, :size, :symbol]
end