defmodule Avance.Core.EntriesTest do
  use Avance.DataCase

  alias Avance.Schemas.Entry
  alias Avance.Core.Entries
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_entries
    setup [:setup_entry]

    test "get all entries", %{entry: entry} do
      assert Entries.all() == [entry]
    end

    test "get last entry", %{entry: entry} do
      assert Entries.last(1) == [entry]
    end

    test "get entry by id", %{entry: entry} do
      assert Entries.get!(entry.id) == entry
    end

    test "update entry", %{entry: entry} do
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Entry{} = entry} = Entries.update(entry, update_attrs)
      assert entry.description == "some updated description"
    end

    test "change/1", %{entry: entry} do
      assert %Ecto.Changeset{} = Entries.change(entry)
    end

    test "delete entry", %{entry: %{id: entry_id} = entry} do
      assert {:ok, %Entry{id: ^entry_id}} = Entries.delete(entry)
      assert Entries.get(entry_id) == nil
    end

    test "delete all entries" do
      assert Entries.delete_all() == {1, nil}
      assert Entries.all() == []
    end
  end

  describe "creating entries" do
    setup [:setup_project]

    @tag :core_entries
    test "create entry", %{project: %{id: project_id}} do
      valid_attrs = %{description: "some description", project_id: project_id}

      assert {:ok, %Entry{} = entry} = Entries.create(valid_attrs)
      assert entry.description == "some description"
    end
  end
end
