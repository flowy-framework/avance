defmodule Avance.Core.NewsiesTest do
  use Avance.DataCase

  alias Avance.Schemas.Newsie
  alias Avance.Core.Newsies
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_newsies
    setup [:setup_newsie]

    test "get all newsies", %{newsie: newsie} do
      assert Newsies.all() == [newsie]
    end

    test "get last newsie", %{newsie: newsie} do
      assert Newsies.last(1) == [newsie]
    end

    test "get newsie by id", %{newsie: newsie} do
      assert Newsies.get!(newsie.id) == newsie
    end

    test "update newsie", %{newsie: newsie} do
      update_attrs = %{
        enabled: false,
        name: "some updated name",
        description: "some updated description",
        settings: %{},
        schedule: "* * * * *",
        timezone: "Europe/Madrid",
        newsie_type: :test
      }

      assert {:ok, %Newsie{} = newsie} = Newsies.update(newsie, update_attrs)
      assert newsie.enabled == false
      assert newsie.name == "some updated name"
      assert newsie.description == "some updated description"
      assert newsie.settings == %{}
      assert newsie.schedule == "* * * * *"
      assert newsie.timezone == "Europe/Madrid"
      assert newsie.newsie_type == :test
    end

    test "change/1", %{newsie: newsie} do
      assert %Ecto.Changeset{} = Newsies.change(newsie)
    end

    test "delete newsie", %{newsie: %{id: newsie_id} = newsie} do
      assert {:ok, %Newsie{id: ^newsie_id}} = Newsies.delete(newsie)
      assert Newsies.get(newsie_id) == nil
    end

    test "delete all newsies" do
      assert Newsies.delete_all() == {1, nil}
      assert Newsies.all() == []
    end
  end

  describe "create" do
    setup [:setup_digest]

    @tag :core_newsies
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

      assert {:ok, %Newsie{} = newsie} = Newsies.create(valid_attrs)
      assert newsie.enabled == true
      assert newsie.name == "some name"
      assert newsie.description == "some description"
      assert newsie.settings == %{}
      assert newsie.schedule == "* * * * *"
      assert newsie.timezone == "Europe/Madrid"
      assert newsie.newsie_type == :test
    end
  end
end
