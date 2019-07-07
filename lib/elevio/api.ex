defmodule Elevio.Api do
  use HTTPoison.Base

  @doc ~S"""
    HTTPoison overridable funciton.. concats the base url to path
    
    ## Examples

      iex> Elevio.Api.process_request_url("/test")
      "https://some_url.com/test"
  """
  def process_request_url(url) do
    Application.get_env(:elevio, Elevio.API)[:elevio_base_url] <> url
  end

  @doc ~S"""
    Another HTTPoison overridable function, This will add Elevio API
    specific headers to the current set of headers.
  """
  def process_request_headers(headers) do
    token = Application.get_env(:elevio, Elevio.API)[:elevio_api_secret]
    key = Application.get_env(:elevio, Elevio.API)[:elevio_api_key]
    Enum.concat(headers,  %{"Authorization": "Bearer #{token}"})
    |> Enum.concat(%{"x-api-key": key})
  end

  def process_response_body(body) do
    Poison.Parser.parse!(body)
  end

  def list_articles params do
    default_page_size = 5
    path = if Map.has_key?(params, "page_number") do
      "/articles?page_size=#{default_page_size}&page=#{params["page_number"]}" #join strings
    else
      "/articles?page_size=#{default_page_size}"
    end
    case Elevio.Api.get(path) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, reason} ->
        IO.puts('Api Error. Reason: #{reason}')
    end
  end

  def search_articles params do
    default_page_size = 5
    path = if Map.has_key?(params, "page_number") do
      "/search/en?rows=#{default_page_size}&page=#{params["page_number"]}&query=#{params["query"]}" #join strings
    else
      "/search/en?rows=#{default_page_size}&query=#{params["query"]}"
    end
    case Elevio.Api.get(path) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, reason} ->
        IO.puts('Api Error. Reason: #{reason}')
    end
  end

  def show_article id do
    case Elevio.Api.get("/articles/#{id}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body["article"]
      {:error, reason} ->
        IO.puts('Api Error. Reason: #{reason}')
    end
  end

end
