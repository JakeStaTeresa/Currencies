defmodule Currencies.Representations do
  @moduledoc """
  A struct that keeps information about the different representations of a currency symbol

  It contains the following fields:
   * `:unicode_decimal` - the unicode decimal representation of the currency symbol
   * `:html` - the html representation of the currency symbol
  """

  @derive [Poison.Encoder]
  defstruct [:unicode_decimal, :html]

  @type t :: %__MODULE__{
                unicode_decimal: [String.t],
                html: String.t
            }
end