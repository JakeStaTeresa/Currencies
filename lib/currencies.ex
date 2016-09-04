defmodule Currencies do
  alias Currencies.Currency
  alias Currencies.CentralBank
  alias Currencies.Representations
  alias Currencies.MinorUnit

  def filter(predicate) when is_function(predicate, 1) do
    all |>
      Enum.filter(predicate)
  end

  def all do
    data_path("currencies.json") |>
      File.read! |>
      Poison.decode!(as: [ %Currency{} ]) |>
      Enum.map(&(get(&1.code)))
  end

  def get(currency_code) when is_binary(currency_code) do
      data_path(Path.join("currencies", String.downcase(currency_code) <> ".json")) |>
      File.read! |>
      Poison.decode!(as: %Currency{representations: %Representations{}, minor_unit: %MinorUnit{}, central_bank: %CentralBank{}})
  end

  defp data_path(path) when is_binary(path) do
    Path.join("data", path) |>
      Path.expand(__DIR__)
  end
end