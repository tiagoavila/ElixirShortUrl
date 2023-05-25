defmodule UrlShorter.Repo.Migrations.AddShortenUrlIdColumn do
  use Ecto.Migration

  def change do
    alter table(:shorten_urls) do
      add :shorten_url_id, :string
    end
  end
end
