defmodule Cellar.Parser.CSV do
  @moduledoc """
  Parser for the Cellar CSV file format.

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
    |> Enum.map(&to_struct/1)
  end

  defp from_file(file) do
    file
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end

  defp to_struct(%{
         "Beer" => beer,
         "Brewery" => brewery,
         "Style" => style,
         "bin_identifier" => box_num,
         "bottle_date" => bottle_date,
         "quantity" => quantity
       }) do
    %Entry{
      name: beer,
      company: brewery,
      style: style,
      vintage: bottle_date,
      box_number: String.to_integer(box_num),
      quantity: String.to_integer(quantity)
    }
  end
end
