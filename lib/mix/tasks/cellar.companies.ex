defmodule Mix.Tasks.Cellar.Companies do
  use Mix.Task

  @shortdoc "List of companies the boxes they are in and how many bottles"
  @moduledoc """
  # Cellar utilities

  Usage: mix cellar.companies
  """

  @impl Mix.Task
  def run(_) do
    Cellar.get_cellar()
    |> company_box_list()
    |> sort_companies_box_list()
    |> Enum.each(fn {brewery, cases} ->
      pretty_cases =
        cases
        |> Enum.sort(fn {_, x}, {_, y} -> x > y end)
        |> Enum.map_join("\n\t", &"#{elem(&1, 0)}: #{elem(&1, 1)}")

      IO.puts("#{brewery} \n\t#{pretty_cases}")
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
