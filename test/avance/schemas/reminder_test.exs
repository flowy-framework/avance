defmodule Avance.Schemas.ReminderTest do
  use ExUnit.Case

  alias Avance.Schemas.Reminder

  @invalid_attrs %{description: nil, reminder_type: nil, settings: nil, schedule: nil}
  @valid_attrs %{
    description: "some description",
    reminder_type: :test,
    settings: %{},
    timezone: "Europe/Madrid",
    schedule: "some schedule",
    project_id: "e44908e1-352a-4c45-a2c3-960ca9ee66de"
  }

  @tag :schema_reminder
  test "Reminder schema metadata" do
    assert Reminder.__schema__(:source) == "reminders"
    assert Reminder.__schema__(:primary_key) == [:id]

    assert Reminder.all_fields() == [
             :description,
             :enabled,
             :id,
             :inserted_at,
             :last_run_at,
             :project_id,
             :reminder_type,
             :schedule,
             :settings,
             :timezone,
             :updated_at
           ]
  end

  describe "changeset/2" do
    @describetag :schema_reminder
    test "with valid params" do
      changeset = Reminder.changeset(%Reminder{}, @valid_attrs)

      assert changeset.required == [
               :description,
               :reminder_type,
               :schedule,
               :project_id,
               :timezone
             ]

      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Reminder.changeset(%Reminder{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
