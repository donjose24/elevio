defmodule Elevio.ApiTest do
  use ExUnit.Case
  doctest Elevio.Api

  setup do
    Application.put_env(:elevio, Elevio.API, elevio_base_url: "https://some_url.com")
  end
end
