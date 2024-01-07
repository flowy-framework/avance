defmodule Avance.Schemas.ProjectTest do
  use ExUnit.Case

  alias Avance.Schemas.Project

  @invalid_attrs %{name: nil, description: nil}
  @valid_attrs %{
    name: "some name",
    description: "some description",
    account_id: "8f0fd118-d143-4153-988e-461ba423c35b"
  }

  @tag :schema_project
  test "Project schema metadata" do
    assert Project.__schema__(:source) == "projects"
    assert Project.__schema__(:primary_key) == [:id]

    assert Project.all_fields() == [
             :account_id,
             :description,
             :id,
             :inserted_at,
             :name,
             :updated_at
           ]
  end

  describe "changeset/2" do
    @describetag :schema_project
    test "with valid params" do
      changeset = Project.changeset(%Project{}, @valid_attrs)
      assert changeset.required == [:name, :description, :account_id]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Project.changeset(%Project{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
