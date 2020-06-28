defmodule Cellar.Parser.CSV do
  @moduledoc """
  Parser for the Cellar CSV file format.

  Accepts the following columns

    - Company, Brewery, Distillery, or Vineyard
    - Name, Beer, or Wine
    - type
    - Bottler
    - Style
    - bin_identifier
    - quantity
    - bottle_date

  Cellar row example:
  %{
    "Beer" => "El Cuatro",
    "Brewery" => "Ale Apothecary",
    "Style" => "American Wild Ale",
    "bin_identifier" => "9",
    "bottle_date" => "2016-04-07",
    "date_acquired" => "2016-09-01",
    "drink_by_date" => "",
    "notes" => "",
    "num_tradeable" => "0",
    "quantity" => "1",
    "size" => ""
  }
  """
  alias Cellar.Entry

  def parse(file_name) do
    file_name
    |> from_file()
    |> Stream.map(&inject_struct/1)
    |> Stream.map(&append_bin/1)
    |> Stream.map(&append_bottle_date/1)
    |> Stream.map(&append_bottle_type/1)
    |> Stream.map(&append_style/1)
    |> Stream.map(&append_quantity/1)
    |> Stream.map(&append_company/1)
    |> Stream.map(&append_bottler/1)
    |> Stream.map(&append_name/1)
    |> Enum.map(&elem(&1, 1))
  end

  defp from_file(file) do
    file
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end

  defp inject_struct(map), do: {map, %Entry{}}

  defp append_bin({%{"bin_identifier" => b} = map, entry}), do: {map, %{entry | box_number: b}}
  defp append_bin(vals), do: vals

  defp append_style({%{"Style" => s} = map, entry}), do: {map, %{entry | style: s}}
  defp append_style({%{"style" => s} = map, entry}), do: {map, %{entry | style: s}}
  defp append_style(vals), do: vals

  defp append_bottle_date({%{"bottle_date" => d} = map, entry}), do: {map, %{entry | vintage: d}}
  defp append_bottle_date(vals), do: vals

  defp append_bottle_type({%{"type" => t} = map, entry}), do: {map, %{entry | type: t}}
  defp append_bottle_type(vals), do: vals

  defp append_quantity({%{"quantity" => n} = map, entry}), do: {map, %{entry | quantity: n}}
  defp append_quantity(vals), do: vals

  defp append_company({%{"Company" => c} = map, entry}), do: {map, %{entry | company: c}}
  defp append_company({%{"company" => c} = map, entry}), do: {map, %{entry | company: c}}
  defp append_company({%{"Brewery" => b} = map, entry}), do: {map, %{entry | company: b}}
  defp append_company({%{"brewery" => b} = map, entry}), do: {map, %{entry | company: b}}
  defp append_company({%{"Vineyard" => v} = map, entry}), do: {map, %{entry | company: v}}
  defp append_company({%{"vineyard" => v} = map, entry}), do: {map, %{entry | company: v}}
  defp append_company({%{"Distillery" => d} = map, entry}), do: {map, %{entry | company: d}}
  defp append_company({%{"distillery" => d} = map, entry}), do: {map, %{entry | company: d}}
  defp append_company(vals), do: vals

  defp append_bottler({%{"Bottler" => b} = map, entry}), do: {map, %{entry | bottler: b}}
  defp append_bottler({%{"bottler" => b} = map, entry}), do: {map, %{entry | bottler: b}}
  defp append_bottler(vals), do: vals

  defp append_name({%{"Name" => n} = map, entry}), do: {map, %{entry | name: n}}
  defp append_name({%{"name" => n} = map, entry}), do: {map, %{entry | name: n}}
  defp append_name({%{"Beer" => b} = map, entry}), do: {map, %{entry | name: b}}
  defp append_name({%{"beer" => b} = map, entry}), do: {map, %{entry | name: b}}
  defp append_name({%{"Wine" => w} = map, entry}), do: {map, %{entry | name: w}}
  defp append_name({%{"wine" => w} = map, entry}), do: {map, %{entry | name: w}}
  defp append_name(vals), do: vals
end
