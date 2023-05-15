defmodule UrlShorter.Repo.Migrations.CreateShortenUrls do
  use Ecto.Migration

  def change do
    create table(:shorten_urls) do
      add :original_url, :string
      add :shorten_url, :string

      timestamps()
    end
  end
end
