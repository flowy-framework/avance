defmodule Avance.Queries.EntryQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Entry
  alias Avance.Queries.EntryQuery
  import Avance.Test.Setups

  @invalid_attrs %{description: nil}

  describe "managing operations with existing data" do
    @describetag :entry_query
    setup [:setup_entry]

    test "get all entrys", %{entry: entry} do
      assert Avance.Queries.EntryQuery.all() == [entry]
    end

    test "get last entry", %{entry: entry} do
      assert Avance.Queries.EntryQuery.last(1) == [entry]
    end

    test "get entry by id", %{entry: entry} do
      assert Avance.Queries.EntryQuery.get!(entry.id) == entry
    end

    test "update entry", %{entry: entry} do
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Entry{} = entry} = EntryQuery.update(entry, update_attrs)
      assert entry.description == "some updated description"
    end

    test "delete entry", %{entry: %{id: entry_id} = entry} do
      assert {:ok, %Entry{id: ^entry_id}} = Avance.Queries.EntryQuery.delete(entry)
      assert Avance.Queries.EntryQuery.get(entry_id) == nil
    end

    test "delete all entrys" do
      assert Avance.Queries.EntryQuery.delete_all() == {1, nil}
      assert Avance.Queries.EntryQuery.all() == []
    end

    test "changeset/1 returns a entry changeset", %{entry: entry} do
      assert %Ecto.Changeset{} = EntryQuery.changeset(entry)
    end
  end

  describe "creating entries" do
    setup [:setup_project]

    @tag :entry_query
    test "create entry", %{project: %{id: project_id}} do
      valid_attrs = %{description: "some description", project_id: project_id}

      assert {:ok, %Entry{} = entry} = EntryQuery.create(valid_attrs)
      assert entry.description == "some description"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EntryQuery.create(@invalid_attrs)
    end
  end
end
