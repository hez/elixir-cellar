# Cellar

## Installation

  * Install `asdf`
  * in project directory `asdf install`
  * install dependancies `mix deps.get`
  * run help `mix help cellar.<cmd>`
  * copy `example_cellar.csv` to `cellar.csv` and edit

To start your Phoenix server:

  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## CSV file

Accepts the following columns:

  - Company, Brewery, Distillery, or Vineyard
  - Name, Beer, or Wine
  - type
  - Bottler
  - Style
  - bin_identifier
  - quantity
  - bottle_date
