defmodule UrlShorter.UrlShortenerContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShorter.UrlShortenerContext` context.
  """

  @doc """
  Generate a shorten_url.
  """
  def shorten_url_fixture(attrs \\ %{}) do
    {:ok, shorten_url} =
      attrs
      |> Enum.into(%{
        original_url: "some original_url",
        shorten_url: "some shorten_url"
      })
      |> UrlShorter.UrlShortenerContext.create_shorten_url()

    shorten_url
  end
end
