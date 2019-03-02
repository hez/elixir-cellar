defmodule CellarWeb.PageController do
  use CellarWeb, :controller

  def about(conn, _params), do: render(conn, "about.html")

  def index(conn, _params) do
    render(conn, "index.html", cellar: Cellar.get_cellar())
  end

  def company(conn, params) do
    cellar = Enum.filter(Cellar.get_cellar(), &(&1.company == params["company"]))

    render(conn, "company.html", cellar: cellar)
  end
end
