defmodule Mix.Tasks.Cellar.Breweries do
  @moduledoc false
  use Mix.Task
  alias Mix.Tasks.Cellar.Companies

  @shortdoc "Alias for cellar.companies"

  @impl Mix.Task
  def run(args), do: Companies.run(args)
end
