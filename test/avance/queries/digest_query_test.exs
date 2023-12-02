defmodule Avance.Queries.DigestQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Digest
  alias Avance.Queries.DigestQuery
  import Avance.Test.Setups

  @invalid_attrs %{description: nil}

  describe "managing operations with existing data" do
    @describetag :digest_query
    setup [:setup_digest]

    test "get all digests", %{digest: digest} do
      assert Avance.Queries.DigestQuery.all() == [digest]
    end

    test "get last digest", %{digest: digest} do
      assert Avance.Queries.DigestQuery.last(1) == [digest]
    end

    test "get digest by id", %{digest: digest} do
      assert Avance.Queries.DigestQuery.get!(digest.id) == digest
    end

    test "update digest", %{digest: digest} do
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Digest{} = digest} = DigestQuery.update(digest, update_attrs)
      assert digest.description == "some updated description"
    end

    test "delete digest", %{digest: %{id: digest_id} = digest} do
      assert {:ok, %Digest{id: ^digest_id}} = Avance.Queries.DigestQuery.delete(digest)
      assert Avance.Queries.DigestQuery.get(digest_id) == nil
    end

    test "delete all digests" do
      assert Avance.Queries.DigestQuery.delete_all() == {1, nil}
      assert Avance.Queries.DigestQuery.all() == []
    end

    test "changeset/1 returns a digest changeset", %{digest: digest} do
      assert %Ecto.Changeset{} = DigestQuery.changeset(digest)
    end
  end

  @tag :digest_query
  test "create digest" do
    valid_attrs = %{
      description: "some description",
      schedule: "* * * * *",
      timezone: "Europe/Madrid"
    }

    assert {:ok, %Digest{} = digest} = DigestQuery.create(valid_attrs)
    assert digest.description == "some description"
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = DigestQuery.create(@invalid_attrs)
  end
end
