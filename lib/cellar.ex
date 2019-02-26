defmodule Cellar do
  @moduledoc """
  Cellar keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Cellar.Parser.CSV

  def get_cellar(), do: CSV.parse(cellar_file())

  defp cellar_file, do: :cellar |> Application.get_env(Cellar) |> Keyword.get(:source_file)
end
