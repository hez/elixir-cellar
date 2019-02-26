defmodule Mix.Tasks.Cellar do
  use Mix.Task

  alias Cellar.Parser.CSV

  def run(args) do
    [cellar_file | commands] = args

    cellar_file
    |> optionally_display_help()
    |> CSV.parse()
    |> exec(commands)
  end

  def optionally_display_help("help") do
    IO.puts("
    Cellar utilities

    Available commands
    ------------------
    breweries - displays list of breweries the boxes they are in and how many bottles.
    box # - displays contents of box #

    Examples
    --------
    mix cellar file.csv box 8
    mix cellar file.csv breweries
    ")
    exit(:normal)
  end

  def optionally_display_help(file), do: file

  def exec(parsed, ["breweries"]), do: exec(parsed, ["companies"])

  def exec(parsed, ["companies"]) do
    parsed
    |> company_box_list()
    |> sort_companies_box_list()
    |> Enum.each(fn {brewery, cases} ->
      pretty_cases =
        cases
        |> Enum.sort(fn {_, x}, {_, y} -> x > y end)
        |> Enum.map(&"#{elem(&1, 0)}: #{elem(&1, 1)}")
        |> Enum.join("\n\t")

      IO.puts("#{brewery} \n\t#{pretty_cases}")
    end)
  end

  def exec(parsed, ["box", box_num]) do
    parsed
    |> Enum.filter(fn %{box_number: box} -> box == String.to_integer(box_num) end)
    |> Enum.each(fn entry ->
      IO.puts("#{entry.quantity}\t#{entry.company} - #{entry.name}")
    end)
  end

  defp company_box_list(cellar) do
    cellar
    |> Enum.map_reduce(%{}, fn entry, acc ->
      cur_company = Map.get(acc, entry.company, %{})

      updated =
        Map.put(
          cur_company,
          entry.box_number,
          Map.get(cur_company, entry.box_number, 0) + entry.quantity
        )

      {updated, Map.put(acc, entry.company, updated)}
    end)
    |> Tuple.to_list()
    |> List.last()
  end

  defp sort_companies_box_list(companies) do
    Enum.sort(companies, fn {_, x}, {_, y} ->
      Enum.count(x) > Enum.count(y)
    end)
  end
end
