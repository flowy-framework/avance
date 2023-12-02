defmodule Avance.Schemas.DigestTest do
  use ExUnit.Case

  alias Avance.Schemas.Digest

  @invalid_attrs %{description: nil}
  @valid_attrs %{
    description: "some description",
    schedule: "* * * * *",
    timezone: "Europe/Madrid"
  }

  @tag :schema_digest
  test "Digest schema metadata" do
    assert Digest.__schema__(:source) == "digests"
    assert Digest.__schema__(:primary_key) == [:id]

    assert Digest.all_fields() == [
             :description,
             :enabled,
             :id,
             :inserted_at,
             :last_run_at,
             :schedule,
             :timezone,
             :updated_at
           ]
  end

  describe "changeset/2" do
    @describetag :schema_digest
    test "with valid params" do
      changeset = Digest.changeset(%Digest{}, @valid_attrs)
      assert changeset.required == [:description, :schedule, :timezone]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Digest.changeset(%Digest{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
