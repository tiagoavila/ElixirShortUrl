defmodule UrlShorter.UrlShortenerContext do
  @moduledoc """
  The UrlShortenerContext context.
  """

  import Ecto.Query, warn: false
  alias UrlShorter.Repo

  alias UrlShorter.UrlShortenerContext.ShortenUrl

  @doc """
  Returns the list of shorten_urls.

  ## Examples

      iex> list_shorten_urls()
      [%ShortenUrl{}, ...]

  """
  def list_shorten_urls do
    Repo.all(ShortenUrl)
  end

  def list_urls do
    query = from su in ShortenUrl, select: su.original_url

    Repo.all(query)
  end

  @doc """
  Gets a single shorten_url.

  Raises `Ecto.NoResultsError` if the Shorten url does not exist.

  ## Examples

      iex> get_shorten_url!(123)
      %ShortenUrl{}

      iex> get_shorten_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shorten_url!(id), do: Repo.get!(ShortenUrl, id)

  @doc """
  Creates a shorten_url.

  ## Examples

      iex> create_shorten_url(%{field: value})
      {:ok, %ShortenUrl{}}

      iex> create_shorten_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shorten_url(attrs \\ %{}) do
    %ShortenUrl{}
    |> ShortenUrl.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shorten_url.

  ## Examples

      iex> update_shorten_url(shorten_url, %{field: new_value})
      {:ok, %ShortenUrl{}}

      iex> update_shorten_url(shorten_url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shorten_url(%ShortenUrl{} = shorten_url, attrs) do
    shorten_url
    |> ShortenUrl.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shorten_url.

  ## Examples

      iex> delete_shorten_url(shorten_url)
      {:ok, %ShortenUrl{}}

      iex> delete_shorten_url(shorten_url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shorten_url(%ShortenUrl{} = shorten_url) do
    Repo.delete(shorten_url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shorten_url changes.

  ## Examples

      iex> change_shorten_url(shorten_url)
      %Ecto.Changeset{data: %ShortenUrl{}}

  """
  def change_shorten_url(%ShortenUrl{} = shorten_url, attrs \\ %{}) do
    ShortenUrl.changeset(shorten_url, attrs)
  end
end
