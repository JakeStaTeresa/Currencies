defmodule Currencies.CentralBank do
  @derive [Poison.Encoder]
  defstruct [:name, :url]
end