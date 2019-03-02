defmodule CellarWeb.Helpers do
  def cellar_name, do: :cellar |> Application.get_env(Cellar) |> Keyword.get(:name)
end
