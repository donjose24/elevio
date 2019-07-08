# Elevio
Sample app to view and search articles using the elevio api written in Elixir and Phoenix

Requirements:
  * Elixir 1.5 or later
  * Phoenix
  * nodejs (>=5.0)

To install and run the application:
  * Set `ELEVIO_API_BASE_URL`, `ELEVIO_API_KEY` and `ELEVIO_API_TOKEN` environment variables (ex. putting it on a .bashrc then `source ~/.bashrc`)
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Notes:
  * Only searching via "en" is supported for now
