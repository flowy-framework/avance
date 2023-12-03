defmodule Avance.Schemas.NewsieTest do
  use ExUnit.Case

  alias Avance.Schemas.Newsie

  @invalid_attrs %{
    enabled: nil,
    name: nil,
    description: nil,
    settings: nil,
    schedule: nil,
    timezone: nil,
    newsie_type: nil
  }

  @valid_attrs %{
    enabled: true,
    name: "some name",
    description: "some description",
    settings: %{},
    schedule: "* * * * *",
    timezone: "Europe/Madrid",
    newsie_type: :test,
    digest_id: "9c2af96f-f429-4578-8688-bae437c340fc"
  }

  @tag :schema_newsie
  test "Newsie schema metadata" do
    assert Newsie.__schema__(:source) == "newsies"
    assert Newsie.__schema__(:primary_key) == [:id]

    assert Newsie.all_fields() == [
             :description,
             :digest_id,
             :enabled,
             :id,
             :inserted_at,
             :last_run_at,
             :name,
             :newsie_type,
             :schedule,
             :settings,
             :timezone,
             :updated_at
           ]
  end

  describe "changeset/2" do
    @describetag :schema_newsie
    test "with valid params" do
      changeset = Newsie.changeset(%Newsie{}, @valid_attrs)

      assert changeset.required == [
               :description,
               :schedule,
               :enabled,
               :timezone,
               :newsie_type,
               :name,
               :digest_id
             ]

      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Newsie.changeset(%Newsie{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
