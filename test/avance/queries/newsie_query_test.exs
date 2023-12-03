defmodule Avance.Queries.NewsieQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Newsie
  alias Avance.Queries.NewsieQuery
  import Avance.Test.Setups

  @invalid_attrs %{
    enabled: nil,
    name: nil,
    description: nil,
    settings: nil,
    schedule: nil,
    timezone: nil,
    newsie_type: nil
  }

  describe "managing operations with existing data" do
    @describetag :newsie_query
    setup [:setup_newsie]

    test "get all newsies", %{newsie: newsie} do
      assert Avance.Queries.NewsieQuery.all() == [newsie]
    end

    test "get last newsie", %{newsie: newsie} do
      assert Avance.Queries.NewsieQuery.last(1) == [newsie]
    end

    test "get newsie by id", %{newsie: newsie} do
      assert Avance.Queries.NewsieQuery.get!(newsie.id) == newsie
    end

    test "update newsie", %{newsie: newsie} do
      update_attrs = %{
        enabled: false,
        name: "some updated name",
        description: "some updated description",
        settings: %{},
        schedule: "* * * * *",
        timezone: "Europe/Madrid",
        newsie_type: "test"
      }

      assert {:ok, %Newsie{} = newsie} = NewsieQuery.update(newsie, update_attrs)
      assert newsie.enabled == false
      assert newsie.name == "some updated name"
      assert newsie.description == "some updated description"
      assert newsie.settings == %{}

      assert newsie.schedule == "* * * * *"
      assert newsie.timezone == "Europe/Madrid"

      assert newsie.newsie_type == :test
    end

    test "delete newsie", %{newsie: %{id: newsie_id} = newsie} do
      assert {:ok, %Newsie{id: ^newsie_id}} = Avance.Queries.NewsieQuery.delete(newsie)
      assert Avance.Queries.NewsieQuery.get(newsie_id) == nil
    end

    test "delete all newsies" do
      assert Avance.Queries.NewsieQuery.delete_all() == {1, nil}
      assert Avance.Queries.NewsieQuery.all() == []
    end

    test "changeset/1 returns a newsie changeset", %{newsie: newsie} do
      assert %Ecto.Changeset{} = NewsieQuery.changeset(newsie)
    end
  end

  describe "create" do
    setup [:setup_digest]

    @tag :newsie_query
    test "create newsie", %{digest: %{id: digest_id}} do
      valid_attrs = %{
        enabled: true,
        name: "some name",
        description: "some description",
        settings: %{},
        schedule: "* * * * *",
        timezone: "Europe/Madrid",
        newsie_type: :test,
        digest_id: digest_id
      }

      assert {:ok, %Newsie{} = newsie} = NewsieQuery.create(valid_attrs)
      assert newsie.enabled == true
      assert newsie.name == "some name"
      assert newsie.description == "some description"
      assert newsie.settings == %{}
      assert newsie.schedule == "* * * * *"
      assert newsie.timezone == "Europe/Madrid"
      assert newsie.newsie_type == :test
      assert newsie.digest_id == digest_id
    end
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = NewsieQuery.create(@invalid_attrs)
  end
end
