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
    |> validate_url_format()
    |> generate_short_url()
    |> validate_required([:original_url, :shorten_url])
  end

  @spec validate_url_format(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_url_format(changeset) do
    validate_change(changeset, :original_url, fn :original_url, original_url ->
      case Regex.match?(~r/^(http|https):\/\/\S+/, original_url) do
        true -> []
        false -> [original_url: "Invalid URL format"]
      end
    end)
  end

  @spec generate_short_url(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp generate_short_url(changeset) do
    generate_short_url(changeset, get_field(changeset, :original_url))
  end

  defp generate_short_url(%{valid?: valid} = changeset, original_url) when valid == false or is_nil(original_url), do: changeset
  defp generate_short_url(changeset, original_url) do
    new_shorten_url = :crypto.hash(:sha, original_url)
    |> Base.encode16
    |> String.slice(0..10)
    |> String.downcase

    put_change(changeset, :shorten_url, new_shorten_url)
  end
end
