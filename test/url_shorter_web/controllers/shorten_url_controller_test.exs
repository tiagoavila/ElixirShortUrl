defmodule UrlShorterWeb.ShortenUrlControllerTest do
  use UrlShorterWeb.ConnCase

  import UrlShorter.UrlShortenerContextFixtures

  @create_attrs %{original_url: "some original_url", shorten_url: "some shorten_url"}
  @update_attrs %{original_url: "some updated original_url", shorten_url: "some updated shorten_url"}
  @invalid_attrs %{original_url: nil, shorten_url: nil}

  describe "index" do
    test "lists all shorten_urls", %{conn: conn} do
      conn = get(conn, Routes.shorten_url_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Shorten urls"
    end
  end

  describe "new shorten_url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.shorten_url_path(conn, :new))
      assert html_response(conn, 200) =~ "New Shorten url"
    end
  end

  describe "create shorten_url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shorten_url_path(conn, :create), shorten_url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.shorten_url_path(conn, :show, id)

      conn = get(conn, Routes.shorten_url_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Shorten url"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shorten_url_path(conn, :create), shorten_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shorten url"
    end
  end

  describe "edit shorten_url" do
    setup [:create_shorten_url]

    test "renders form for editing chosen shorten_url", %{conn: conn, shorten_url: shorten_url} do
      conn = get(conn, Routes.shorten_url_path(conn, :edit, shorten_url))
      assert html_response(conn, 200) =~ "Edit Shorten url"
    end
  end

  describe "update shorten_url" do
    setup [:create_shorten_url]

    test "redirects when data is valid", %{conn: conn, shorten_url: shorten_url} do
      conn = put(conn, Routes.shorten_url_path(conn, :update, shorten_url), shorten_url: @update_attrs)
      assert redirected_to(conn) == Routes.shorten_url_path(conn, :show, shorten_url)

      conn = get(conn, Routes.shorten_url_path(conn, :show, shorten_url))
      assert html_response(conn, 200) =~ "some updated original_url"
    end

    test "renders errors when data is invalid", %{conn: conn, shorten_url: shorten_url} do
      conn = put(conn, Routes.shorten_url_path(conn, :update, shorten_url), shorten_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shorten url"
    end
  end

  describe "delete shorten_url" do
    setup [:create_shorten_url]

    test "deletes chosen shorten_url", %{conn: conn, shorten_url: shorten_url} do
      conn = delete(conn, Routes.shorten_url_path(conn, :delete, shorten_url))
      assert redirected_to(conn) == Routes.shorten_url_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.shorten_url_path(conn, :show, shorten_url))
      end
    end
  end

  defp create_shorten_url(_) do
    shorten_url = shorten_url_fixture()
    %{shorten_url: shorten_url}
  end
end
