defmodule UrlShorterWeb.ShortenUrlController do
  use UrlShorterWeb, :controller

  alias UrlShorter.UrlShortenerContext
  alias UrlShorter.UrlShortenerContext.ShortenUrl

  def index(conn, _params) do
    shorten_urls = UrlShortenerContext.list_shorten_urls()
    render(conn, "index.html", shorten_urls: shorten_urls)
  end

  def new(conn, _params) do
    changeset = UrlShortenerContext.change_shorten_url(%ShortenUrl{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"shorten_url" => shorten_url_params}) do


    case UrlShortenerContext.create_shorten_url(shorten_url_params) do
      {:ok, shorten_url} ->
        conn
        |> put_flash(:info, "Shorten url created successfully.")
        |> redirect(to: Routes.shorten_url_path(conn, :show, shorten_url))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shorten_url = UrlShortenerContext.get_shorten_url!(id)
    render(conn, "show.html", shorten_url: shorten_url)
  end

  def edit(conn, %{"id" => id}) do
    shorten_url = UrlShortenerContext.get_shorten_url!(id)
    changeset = UrlShortenerContext.change_shorten_url(shorten_url)
    render(conn, "edit.html", shorten_url: shorten_url, changeset: changeset)
  end

  def update(conn, %{"id" => id, "shorten_url" => shorten_url_params}) do
    shorten_url = UrlShortenerContext.get_shorten_url!(id)

    case UrlShortenerContext.update_shorten_url(shorten_url, shorten_url_params) do
      {:ok, shorten_url} ->
        conn
        |> put_flash(:info, "Shorten url updated successfully.")
        |> redirect(to: Routes.shorten_url_path(conn, :show, shorten_url))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", shorten_url: shorten_url, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shorten_url = UrlShortenerContext.get_shorten_url!(id)
    {:ok, _shorten_url} = UrlShortenerContext.delete_shorten_url(shorten_url)

    conn
    |> put_flash(:info, "Shorten url deleted successfully.")
    |> redirect(to: Routes.shorten_url_path(conn, :index))
  end
end
