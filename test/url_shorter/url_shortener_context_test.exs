defmodule UrlShorter.UrlShortenerContextTest do
  use UrlShorter.DataCase

  alias UrlShorter.UrlShortenerContext

  describe "shorten_urls" do
    alias UrlShorter.UrlShortenerContext.ShortenUrl

    import UrlShorter.UrlShortenerContextFixtures

    @invalid_attrs %{original_url: nil, shorten_url: nil}

    test "list_shorten_urls/0 returns all shorten_urls" do
      shorten_url = shorten_url_fixture()
      assert UrlShortenerContext.list_shorten_urls() == [shorten_url]
    end

    test "get_shorten_url!/1 returns the shorten_url with given id" do
      shorten_url = shorten_url_fixture()
      assert UrlShortenerContext.get_shorten_url!(shorten_url.id) == shorten_url
    end

    test "create_shorten_url/1 with valid data creates a shorten_url" do
      valid_attrs = %{original_url: "some original_url", shorten_url: "some shorten_url"}

      assert {:ok, %ShortenUrl{} = shorten_url} = UrlShortenerContext.create_shorten_url(valid_attrs)
      assert shorten_url.original_url == "some original_url"
      assert shorten_url.shorten_url == "some shorten_url"
    end

    test "create_shorten_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UrlShortenerContext.create_shorten_url(@invalid_attrs)
    end

    test "update_shorten_url/2 with valid data updates the shorten_url" do
      shorten_url = shorten_url_fixture()
      update_attrs = %{original_url: "some updated original_url", shorten_url: "some updated shorten_url"}

      assert {:ok, %ShortenUrl{} = shorten_url} = UrlShortenerContext.update_shorten_url(shorten_url, update_attrs)
      assert shorten_url.original_url == "some updated original_url"
      assert shorten_url.shorten_url == "some updated shorten_url"
    end

    test "update_shorten_url/2 with invalid data returns error changeset" do
      shorten_url = shorten_url_fixture()
      assert {:error, %Ecto.Changeset{}} = UrlShortenerContext.update_shorten_url(shorten_url, @invalid_attrs)
      assert shorten_url == UrlShortenerContext.get_shorten_url!(shorten_url.id)
    end

    test "delete_shorten_url/1 deletes the shorten_url" do
      shorten_url = shorten_url_fixture()
      assert {:ok, %ShortenUrl{}} = UrlShortenerContext.delete_shorten_url(shorten_url)
      assert_raise Ecto.NoResultsError, fn -> UrlShortenerContext.get_shorten_url!(shorten_url.id) end
    end

    test "change_shorten_url/1 returns a shorten_url changeset" do
      shorten_url = shorten_url_fixture()
      assert %Ecto.Changeset{} = UrlShortenerContext.change_shorten_url(shorten_url)
    end
  end
end
