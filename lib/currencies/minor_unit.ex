defmodule Currencies.MinorUnit do
  @moduledoc """
  A struct that keeps information about the sub-unit or minor unit of a currency

  It contains the following fields:
   * `:name` - the name of the minor unit
   * `:size` - the size of the minor unit in relation to the currency
   * `:symbol` - the symbol of the minor unit
  """

  defstruct [:name, :size, :symbol]

  @type t :: %__MODULE__{
              name: String.t,
              size: String.t,
              symbol: String.t
            }
end