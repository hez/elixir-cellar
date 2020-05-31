defmodule Mix.Tasks.Cellar.Box do
  use Mix.Task

  @shortdoc "Display contents of specific box"
  @moduledoc """
  # Cellar Box
  Display contents of box.

  Usage: mix cellar.box #
  """

  @impl Mix.Task
  def run([box_num]) do
    beers =
      Enum.filter(Cellar.get_cellar(), fn %{box_number: box} ->
        box == String.to_integer(box_num)
      end)

    Enum.each(beers, &IO.puts("#{&1.quantity}\t#{&1.company} - #{&1.name} (#{&1.vintage})"))
    IO.puts("----")
    IO.puts("#{Enum.reduce(beers, 0, &(&1.quantity + &2))}")
  end
end
