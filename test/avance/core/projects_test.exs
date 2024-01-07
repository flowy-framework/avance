defmodule Avance.Core.ProjectsTest do
  use Avance.DataCase

  alias Avance.Schemas.Project
  alias Avance.Core.Projects
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_projects
    setup [:setup_project]

    test "get all projects", %{project: project} do
      assert Projects.all() == [project]
    end

    test "get last project", %{project: project} do
      assert Projects.last(1) == [project]
    end

    test "get project by id", %{project: project} do
      assert Projects.get!(project.id) == project
    end

    test "update project", %{project: project} do
      attrs = %{name: "Updated Vendor"}
      assert {:ok, %Project{name: "Updated Vendor"}} = Projects.update(project, attrs)
    end

    test "change/1", %{project: project} do
      assert %Ecto.Changeset{changes: %{name: "New name"}} =
               Projects.change(project, %{name: "New name"})
    end

    test "delete project", %{project: %{id: project_id} = project} do
      assert {:ok, %Project{id: ^project_id}} = Projects.delete(project)
      assert Projects.get(project_id) == nil
    end

    test "delete all projects" do
      assert Projects.delete_all() == {1, nil}
      assert Projects.all() == []
    end
  end

  setup [:setup_account]

  @tag :core_projects
  test "create project", %{account: %{id: account_id}} do
    valid_attrs = %{name: "some name", description: "some description", account_id: account_id}

    assert {:ok, %Project{} = project} = Projects.create(valid_attrs)
    assert project.name == "some name"
    assert project.description == "some description"
  end
end
