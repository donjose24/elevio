defmodule ElevioWeb.PageController do
  use ElevioWeb, :controller

  @doc ~S"""
    Controller method to list articles
  """
  def index(conn, _params) do
    query_params = conn.query_params
    case Elevio.Api.list_articles query_params do
      {:ok, body, status_code} ->
        resolve_page(status_code, conn, body, fn(body, conn) ->
          body = Poison.Parser.parse!(body)
          render(conn, "index.html", %{articles: body["articles"], total_pages: body["total_pages"], page_number: body["page_number"]})
        end)
    end
  end

  @doc ~S"""
    Controller method to view details of an article
  """
  def show(conn, %{"id" => id}) do
    case Elevio.Api.show_article(id) do
      {:ok, body, status_code} ->
        resolve_page(status_code, conn, body, fn(body, conn) ->
          body = Poison.Parser.parse!(body)
          render(conn, "show.html", %{article: body["article"]})
        end)
    end
  end

  @doc ~S"""
    Controller method to search for an article.
  """
  def search(conn, _params) do
    query_params = conn.query_params

    case Elevio.Api.search_articles query_params do
      {:ok, body, status_code} ->
        resolve_page(status_code, conn, body, fn(body, conn) ->
          body = Poison.Parser.parse!(body)
          render(conn, "search.html", %{results: body["results"], total_pages: body["totalPages"], page_number: body["currentPage"], query: body["queryTerm"]})
        end)
    end
  end

  @doc ~S"""
    Checks the status codes for any invalid response and renders the success page
  """
  def resolve_page(status_code, conn, body, renderer) do
    case status_code do
      401 ->
        render(conn, "401.html")
      403 ->
        render(conn, "403.html")
      404 ->
        render(conn, "404.html")
      _ ->
        renderer.(body, conn)
    end
  end
end
