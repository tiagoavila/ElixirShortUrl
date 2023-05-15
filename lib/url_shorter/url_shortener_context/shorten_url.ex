defmodule UrlShorter.UrlShortenerContext.ShortenUrl do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shorten_urls" do
    field :original_url, :string
    field :shorten_url, :string

    timestamps()
  end

  @doc false
  def changeset(shorten_url, attrs) do
    shorten_url
    |> cast(attrs, [:original_url, :shorten_url])
    |> validate_required([:original_url, :shorten_url])
  end
end
