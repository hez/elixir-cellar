defmodule CellarWeb.Router do
  use CellarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CellarWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/company", PageController, :company
  end

  # Other scopes may use custom stacks.
  # scope "/api", CellarWeb do
  #   pipe_through :api
  # end
end
