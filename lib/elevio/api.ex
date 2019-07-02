defmodule Elevio.Api do
  use HTTPoison.Base

  def process_request_url(url) do
    Application.get_env(:elevio, Elevio.API)[:elevio_base_url] <> url
  end

  def process_request_headers(headers) do
    token = Application.get_env(:elevio, Elevio.API)[:elevio_api_secret]
    key = Application.get_env(:elevio, Elevio.API)[:elevio_api_key]
    Enum.concat(headers,  %{"Authorization": "Bearer #{token}"})
    |> Enum.concat(%{"x-api-key": key})
  end

  def process_response_body(body) do
    Poison.Parser.parse!(body).body
  end

end
