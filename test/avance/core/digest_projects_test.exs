defmodule Avance.Core.DigestProjectsTest do
  use Avance.DataCase

  alias Avance.Schemas.DigestProject
  alias Avance.Core.DigestProjects
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_digest_projects
    setup [:setup_project, :setup_digest, :setup_digest_project]

    test "get all digest_projects", %{digest_project: digest_project} do
      assert DigestProjects.all() == [digest_project]
    end

    test "get last digest_project", %{digest_project: digest_project} do
      assert DigestProjects.last(1) == [digest_project]
    end

    test "get digest_project by id", %{digest_project: digest_project} do
      assert DigestProjects.get!(digest_project.id) == digest_project
    end

    test "change/1", %{digest_project: digest_project} do
      assert %Ecto.Changeset{} = DigestProjects.change(digest_project)
    end

    test "delete digest_project", %{digest_project: %{id: digest_project_id} = digest_project} do
      assert {:ok, %DigestProject{id: ^digest_project_id}} = DigestProjects.delete(digest_project)
      assert DigestProjects.get(digest_project_id) == nil
    end

    test "delete all digest_projects" do
      assert DigestProjects.delete_all() == {1, nil}
      assert DigestProjects.all() == []
    end
  end

  describe "create diggest" do
    setup [:setup_project, :setup_digest]
    @tag :core_digest_projects
    test "create digest_project", %{project: %{id: project_id}, digest: %{id: digest_id}} do
      valid_attrs = %{project_id: project_id, digest_id: digest_id}

      assert {:ok, %DigestProject{} = digest_project} = DigestProjects.create(valid_attrs)
      assert digest_project.project_id == project_id
    end
  end
end
