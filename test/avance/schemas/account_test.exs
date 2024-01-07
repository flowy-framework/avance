defmodule Avance.Schemas.AccountTest do
  use ExUnit.Case

  alias Avance.Schemas.Account

  @invalid_attrs %{name: nil, logo: nil}
  @valid_attrs %{
    name: "some name",
    logo: "some logo",
    owner_id: "e805cdf5-7344-4f98-b08f-fd70c3d338bd"
  }

  @tag :schema_account
  test "Account schema metadata" do
    assert Account.__schema__(:source) == "accounts"
    assert Account.__schema__(:primary_key) == [:id]

    assert Account.all_fields() == [:id, :inserted_at, :logo, :name, :owner_id, :updated_at]
  end

  describe "changeset/2" do
    @describetag :schema_account
    test "with valid params" do
      changeset = Account.changeset(%Account{}, @valid_attrs)
      assert changeset.required == [:name, :logo, :owner_id]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Account.changeset(%Account{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
