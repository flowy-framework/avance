defmodule Avance.Queries.DigestProjectQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.DigestProject
  alias Avance.Queries.DigestProjectQuery
  import Avance.Test.Setups

  @invalid_attrs %{description: nil}

  describe "managing operations with existing data" do
    @describetag :digest_project_query
    setup [:setup_project, :setup_digest, :setup_digest_project]

    test "get all digest_projects", %{digest_project: digest_project} do
      assert Avance.Queries.DigestProjectQuery.all() == [digest_project]
    end

    test "get last digest_project", %{digest_project: digest_project} do
      assert Avance.Queries.DigestProjectQuery.last(1) == [digest_project]
    end

    test "get digest_project by id", %{digest_project: digest_project} do
      assert Avance.Queries.DigestProjectQuery.get!(digest_project.id) == digest_project
    end

    test "delete digest_project", %{digest_project: %{id: digest_project_id} = digest_project} do
      assert {:ok, %DigestProject{id: ^digest_project_id}} =
               Avance.Queries.DigestProjectQuery.delete(digest_project)

      assert Avance.Queries.DigestProjectQuery.get(digest_project_id) == nil
    end

    test "delete all digest_projects" do
      assert Avance.Queries.DigestProjectQuery.delete_all() == {1, nil}
      assert Avance.Queries.DigestProjectQuery.all() == []
    end

    test "changeset/1 returns a digest_project changeset", %{digest_project: digest_project} do
      assert %Ecto.Changeset{} = DigestProjectQuery.changeset(digest_project)
    end
  end

  describe "create digest_project" do
    setup [:setup_project, :setup_digest]

    @tag :digest_project_query
    test "create digest_project", %{project: %{id: project_id}, digest: %{id: digest_id}} do
      valid_attrs = %{project_id: project_id, digest_id: digest_id}

      assert {:ok, %DigestProject{} = digest_project} = DigestProjectQuery.create(valid_attrs)
      assert digest_project.project_id == project_id
    end
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = DigestProjectQuery.create(@invalid_attrs)
  end
end
