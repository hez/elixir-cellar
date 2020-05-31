defmodule Mix.Tasks.Cellar.Breweries do
  use Mix.Task

  @shortdoc "Alias for cellar.companies"

  @impl Mix.Task
  def run(args), do: Mix.Tasks.Cellar.Companies.run(args)
end
