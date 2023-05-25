defmodule UrlShorter.UrlShortenerContext.ShortenUrl do
  use Ecto.Schema
  import Ecto.Changeset

  alias UrlShorter.UrlShorterBloomFilter

  schema "shorten_urls" do
    field :original_url, :string
    field :shorten_url, :string
    field :shorten_url_id, :string

    timestamps()
  end

  @doc false
  def changeset(shorten_url, attrs) do
    shorten_url
    |> cast(attrs, [:original_url, :shorten_url, :shorten_url_id])
    |> validate_url_format()
    |> check_url_has_been_shorted()
    |> generate_short_url()
    |> validate_required([:original_url, :shorten_url, :shorten_url_id])
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

  @spec check_url_has_been_shorted(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp check_url_has_been_shorted(changeset) do
    validate_change(changeset, :original_url, fn :original_url, original_url ->
      case UrlShorterBloomFilter.contains_url?(original_url) do
        true -> [original_url: "URL has been already registered"]
        false -> add_url_to_bloom_filter_and_return_no_error(original_url)
      end
    end)
  end

  defp add_url_to_bloom_filter_and_return_no_error(original_url) do
    UrlShorterBloomFilter.add_url(original_url)

    []
  end

  @spec generate_short_url(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp generate_short_url(changeset) do
    generate_short_url(changeset, get_field(changeset, :original_url))
  end

  defp generate_short_url(%{valid?: valid} = changeset, original_url) when valid == false or is_nil(original_url), do: changeset
  defp generate_short_url(changeset, original_url) do
    new_shorten_url_id = :crypto.hash(:sha, original_url)
    |> Base.encode16
    |> String.slice(0..10)
    |> String.downcase
    |> then(fn shorten_url -> shorten_url end)

    new_shorten_url = Application.fetch_env!(:url_shorter, :base_url_for_shorter) <> new_shorten_url_id

    put_change(changeset, :shorten_url, new_shorten_url)
    |> put_change(:shorten_url_id, new_shorten_url_id)
  end
end
