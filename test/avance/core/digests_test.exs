defmodule Avance.Core.DigestsTest do
  use Avance.DataCase

  alias Avance.Schemas.{Digest, DigestProject}
  alias Avance.Core.Digests
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_digests
    setup [:setup_digest]

    test "get all digests", %{digest: digest} do
      assert Digests.all() == [digest]
    end

    test "get last digest", %{digest: digest} do
      assert Digests.last(1) == [digest]
    end

    test "get digest by id", %{digest: digest} do
      assert Digests.get!(digest.id) == digest
    end

    test "update digest", %{digest: digest} do
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Digest{} = digest} = Digests.update(digest, update_attrs)
      assert digest.description == "some updated description"
    end

    test "change/1", %{digest: digest} do
      assert %Ecto.Changeset{} = Digests.change(digest)
    end

    test "delete digest", %{digest: %{id: digest_id} = digest} do
      assert {:ok, %Digest{id: ^digest_id}} = Digests.delete(digest)
      assert Digests.get(digest_id) == nil
    end

    test "delete all digests" do
      assert Digests.delete_all() == {1, nil}
      assert Digests.all() == []
    end
  end

  @tag :core_digests
  test "create digest" do
    valid_attrs = %{
      description: "some description",
      schedule: "* * * * *",
      timezone: "Europe/Madrid"
    }

    assert {:ok, %Digest{} = digest} = Digests.create(valid_attrs)
    assert digest.description == "some description"
  end

  describe "add project to digest" do
    setup [:setup_project, :setup_digest]

    test "add project to digest", %{
      project: %{id: project_id} = project,
      digest: %{id: digest_id} = digest
    } do
      assert {:ok, %DigestProject{} = digest_project} = Digests.add_project(digest, project)
      assert digest_project.project_id == project_id
      assert digest_project.digest_id == digest_id
    end
  end
end
