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

  @doc ~S"""
    List all articls. paginated by 5 items by default. Update the variable value as you please.
  """
  def list_articles params do
    default_page_size = 5
    path = if Map.has_key?(params, "page_number") do
      "/articles?page_size=#{default_page_size}&page=#{params["page_number"]}" #join strings
    else
      "/articles?page_size=#{default_page_size}"
    end
    case Elevio.Api.get(path) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        {:ok, body, code}
      {:error, reason} ->
        #log the reason in the standard output. in real life application, we might put this error on something like rollbar.
        IO.puts('Api Error. Reason: #{reason}')
        {:error, reason}
    end
  end

  @doc ~S"""
    Search an article using query term. paginate by 5 items.
  """
  def search_articles params do
    default_page_size = 5
    path = if Map.has_key?(params, "page_number") do
      "/search/en?rows=#{default_page_size}&page=#{params["page_number"]}&query=#{params["query"]}" #join strings
    else
      "/search/en?rows=#{default_page_size}&query=#{params["query"]}"
    end
    case Elevio.Api.get(path) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        {:ok, body, code}
      {:error, reason} ->
        IO.puts('Api Error. Reason: #{reason}')
        {:error, reason}
    end
  end

  @doc ~S"""
    Looks for an article by ID and returns the result.
  """
  def show_article id do
    case Elevio.Api.get("/articles/#{id}") do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        {:ok, body, code}
      {:error, reason} ->
        IO.puts('Api Error. Reason: #{reason}')
        {:error, reason}
    end
  end
end
