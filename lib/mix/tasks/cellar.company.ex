defmodule Mix.Tasks.Cellar.Company do
  use Mix.Task

  @shortdoc "List all entries for a specific company"
  @moduledoc """
  # Cellar utilities

  Usage: `mix cellar.company "The Bruery"` or partial match `mix cellar.company "bruery"`
  """

  def run([company]) do
    IO.puts("Matches for #{company}")
    IO.puts(String.duplicate("-", String.length(company)))

    Cellar.get_cellar()
    |> Enum.filter(&filter_by_company(&1, company))
    |> Enum.sort(&(&1.box_number < &2.box_number))
    |> Enum.chunk_by(& &1.box_number)
    |> Enum.each(fn entries ->
      IO.puts("Box: #{List.first(entries).box_number}")

      Enum.each(entries, fn entry ->
        IO.puts("\t#{entry.quantity} - #{entry.company} #{entry.name}")
      end)
    end)
  end

  defp filter_by_company(entry, company),
    do: String.contains?(String.downcase(entry.company), String.downcase(company))
end
