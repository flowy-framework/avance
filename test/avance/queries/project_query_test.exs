defmodule Avance.Queries.ProjectQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Project
  alias Avance.Queries.ProjectQuery
  import Avance.Test.Setups

  @invalid_attrs %{name: nil, description: nil}

  describe "managing operations with existing data" do
    @describetag :project_query
    setup [:setup_project]

    test "get all projects", %{project: project} do
      assert Avance.Queries.ProjectQuery.all() == [project]
    end

    test "get last project", %{project: project} do
      assert Avance.Queries.ProjectQuery.last(1) == [project]
    end

    test "get project by id", %{project: project} do
      assert Avance.Queries.ProjectQuery.get!(project.id) == project
    end

    test "update project", %{project: project} do
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Project{} = project} = ProjectQuery.update(project, update_attrs)
      assert project.name == "some updated name"
      assert project.description == "some updated description"
    end

    test "delete project", %{project: %{id: project_id} = project} do
      assert {:ok, %Project{id: ^project_id}} = Avance.Queries.ProjectQuery.delete(project)
      assert Avance.Queries.ProjectQuery.get(project_id) == nil
    end

    test "delete all projects" do
      assert Avance.Queries.ProjectQuery.delete_all() == {1, nil}
      assert Avance.Queries.ProjectQuery.all() == []
    end

    test "changeset/1 returns a project changeset", %{project: project} do
      assert %Ecto.Changeset{} = ProjectQuery.changeset(project)
    end
  end

  setup [:setup_account]

  @tag :project_query
  test "create project", %{account: %{id: account_id}} do
    valid_attrs = %{name: "some name", description: "some description", account_id: account_id}

    assert {:ok, %Project{} = project} = ProjectQuery.create(valid_attrs)
    assert project.name == "some name"
    assert project.description == "some description"
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ProjectQuery.create(@invalid_attrs)
  end
end
