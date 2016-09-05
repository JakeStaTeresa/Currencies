Mix.start()
Mix.shell(Mix.Shell.Process)

defmodule Mix.Tasks.Currencies.JsonToBinaryTest do
  use ExUnit.Case
  alias Mix.Tasks.Currencies.JsonToBinary
  doctest JsonToBinary

  test "run generates the binary and is able to deserialise properly" do
    binary_path = Path.expand("lib/data/currencies.bin")

    if File.exists?(binary_path) do
      File.rm! binary_path
    end

    assert !File.exists?(binary_path)

    JsonToBinary.run([])

    assert File.exists?(binary_path)

    currencies = Currencies.all
    assert is_list(currencies)
    assert Enum.count(currencies) == 162
    assert Enum.at(currencies, 0, nil).__struct__ == Currencies.Currency
  end

end
