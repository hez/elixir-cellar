defmodule Mix.Tasks.Cellar.Brewery do
  use Mix.Task
  alias Mix.Tasks.Cellar.Company

  @shortdoc "Alias for cellar.company"

  @impl Mix.Task
  def run(args), do: Company.run(args)
end
