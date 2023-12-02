defmodule Avance.Schemas.EntryTest do
  use ExUnit.Case

  alias Avance.Schemas.Entry

  @invalid_attrs %{description: nil}
  @valid_attrs %{
    description: "some description",
    project_id: "ce8860e9-a893-4eba-a9d3-74aa515877c1"
  }

  @tag :schema_entry
  test "Entry schema metadata" do
    assert Entry.__schema__(:source) == "entries"
    assert Entry.__schema__(:primary_key) == [:id]

    assert Entry.all_fields() == [:description, :id, :inserted_at, :project_id, :updated_at]
  end

  describe "changeset/2" do
    @describetag :schema_entry
    test "with valid params" do
      changeset = Entry.changeset(%Entry{}, @valid_attrs)
      assert changeset.required == [:description, :project_id]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Entry.changeset(%Entry{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
