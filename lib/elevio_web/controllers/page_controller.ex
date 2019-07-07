defmodule ElevioWeb.PageController do
  use ElevioWeb, :controller

  def index(conn, _params) do
    query_params = conn.query_params
    body = Elevio.Api.list_articles query_params
    render(conn, "index.html", %{articles: body["articles"], total_pages: body["total_pages"], page_number: body["page_number"]})
  end

  def show(conn, %{"id" => id}) do
    article = Elevio.Api.show_article(id)
    render(conn, "show.html", %{article: article})
  end

  def search(conn, _params) do
    query_params = conn.query_params
    body = Elevio.Api.search_articles query_params
    render(conn, "search.html", %{results: body["results"], total_pages: body["totalPages"], page_number: body["currentPage"], query: body["queryTerm"]})
  end
end
