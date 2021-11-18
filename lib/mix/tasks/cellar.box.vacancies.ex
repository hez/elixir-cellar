defmodule Mix.Tasks.Cellar.Vacancies do
  use Mix.Task

  @box_size 12

  @shortdoc "Displays number of empty slots in box and what breweries are in that box"
  @moduledoc """
  # Cellar Box Vacancies

  Usage: mix cellar.box.vacancies
  """

  @impl Mix.Task
  def run(_) do
    parsed = Cellar.get_cellar()
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

      IO.puts(
        "\t#{parsed |> box_company_list(box) |> Enum.map_join("\n\t", &"#{elem(&1, 0)}: #{elem(&1, 1)}")}"
      )
    end)
  end

  defp box_available_colour(available_count) when available_count > 3, do: IO.ANSI.light_red()
  defp box_available_colour(1), do: IO.ANSI.green()
  defp box_available_colour(_available_count), do: IO.ANSI.yellow()

  defp box_company_list(cellar, box) do
    cellar
    |> Enum.filter(&(&1.box_number == box))
    |> Enum.map(&{&1.company, &1.quantity})
    |> Enum.reduce(%{}, fn {brewery, quantity}, acc ->
      Map.put(acc, brewery, Map.get(acc, brewery, 0) + quantity)
    end)
  end
end
