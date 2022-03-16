defmodule CellarWeb.PageView do
  use CellarWeb, :view

  def cellar_name, do: :cellar |> Application.get_env(Cellar) |> Keyword.get(:name)
end
