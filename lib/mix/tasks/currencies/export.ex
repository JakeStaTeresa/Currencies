defmodule Mix.Tasks.Currencies.JsonToBinary do
  use Mix.Task

  alias Currencies.Currency
  alias Currencies.CentralBank
  alias Currencies.Representations
  alias Currencies.MinorUnit

  def run(_) do
    File.write! "lib/data/currencies.bin", :erlang.term_to_binary(load_currencies)
  end

  defp load_currencies do
    data_path("currencies.json") |>
      File.read! |>
      Poison.decode!(as: [ %Currency{} ]) |>
      Enum.map(&(load_currency(&1.code)))
  end

  defp load_currency(currency_code) when is_binary(currency_code) do
      data_path(Path.join("currencies", String.downcase(currency_code) <> ".json")) |>
      File.read! |>
      Poison.decode!(as: %Currency{representations: %Representations{}, minor_unit: %MinorUnit{}, central_bank: %CentralBank{}})
  end

  defp data_path(path) when is_binary(path) do
    Path.join("data", path) |>
      Path.expand(__DIR__)
  end
end