defmodule Avance.Schemas.DigestProjectTest do
  use ExUnit.Case

  alias Avance.Schemas.DigestProject

  @invalid_attrs %{description: nil}
  @valid_attrs %{
    project_id: "8e9f5b5b-2f4a-4689-9355-325223250fcc",
    digest_id: "1c1e5105-1fee-4fa2-8647-bc2178907714"
  }

  @tag :schema_digest_project
  test "Digest project schema metadata" do
    assert DigestProject.__schema__(:source) == "digest_projects"
    assert DigestProject.__schema__(:primary_key) == [:id]

    assert DigestProject.all_fields() == [
             :digest_id,
             :id,
             :inserted_at,
             :project_id,
             :updated_at
           ]
  end

  describe "changeset/2" do
    @describetag :schema_digest_project
    test "with valid params" do
      changeset = DigestProject.changeset(%DigestProject{}, @valid_attrs)
      assert changeset.required == [:digest_id, :project_id, :digest_id]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = DigestProject.changeset(%DigestProject{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
