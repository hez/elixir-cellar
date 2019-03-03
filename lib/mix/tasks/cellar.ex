defmodule Mix.Tasks.Cellar do
  use Mix.Task

  @box_size 12

  def run(args) do
    optionally_display_help(args)
    exec(Cellar.get_cellar(), args)
  end

  def optionally_display_help(["help"]) do
    IO.puts("
    Cellar utilities

    Usage: mix cellar <command>

    Available commands
    ------------------
    breweries - displays list of breweries the boxes they are in and how many bottles.
    box # - displays contents of box #
    box vacancies - displays number of empty slots in box and what breweries are in that box.

    Examples
    --------
    mix cellar box 8
    mix cellar breweries
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

  def exec(parsed, ["box", "vacancies"]) do
    IO.puts("Box vacancies")
    IO.puts("box - vacancy")
    IO.puts("-------------")

    parsed
    |> Enum.map_reduce(%{}, fn %{box_number: box, quantity: quantity}, acc ->
      {quantity, Map.put(acc, box, Map.get(acc, box, 0) + quantity)}
    end)
    |> Tuple.to_list()
    |> List.last()
    |> Enum.sort(fn {_, xfree}, {_, yfree} -> xfree < yfree end)
    |> Enum.filter(&(elem(&1, 1) < @box_size))
    |> Enum.each(fn {box, count} ->
      IO.puts(
        "#{String.pad_leading(Integer.to_string(box), 3)} - " <>
          box_available_colour(@box_size - count) <> "#{@box_size - count}" <> IO.ANSI.reset()
      )

      IO.puts("\t#{parsed |> box_company_list(box) |> Enum.map(&("#{elem(&1, 0)}: #{elem(&1, 1)}")) |> Enum.join("\n\t")}")
    end)
  end

  def exec(parsed, ["box", box_num]) do
    parsed
    |> Enum.filter(fn %{box_number: box} -> box == String.to_integer(box_num) end)
    |> Enum.each(fn entry ->
      IO.puts("#{entry.quantity}\t#{entry.company} - #{entry.name}")
    end)
  end

  defp box_available_colour(available_count) when available_count > 3, do: IO.ANSI.light_red()
  defp box_available_colour(1), do: IO.ANSI.green()
  defp box_available_colour(available_count), do: IO.ANSI.yellow()

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

  defp box_company_list(cellar, box) do
    cellar
    |> Enum.filter(&(&1.box_number == box))
    |> Enum.map(& {&1.company, &1.quantity})
    |> Enum.reduce(%{}, fn {brewery, quantity}, acc ->
      Map.put(acc, brewery, Map.get(acc, brewery, 0) + quantity)
    end)
  end

  defp sort_companies_box_list(companies) do
    Enum.sort(companies, fn {_, x}, {_, y} ->
      Enum.count(x) > Enum.count(y)
    end)
  end
end
