defmodule Avance.Schemas.ReminderTest do
  use ExUnit.Case

  alias Avance.Schemas.Reminder

  @invalid_attrs %{description: nil, reminder_type: nil, settings: nil, schedule: nil}
  @valid_attrs %{description: "some description", reminder_type: "some reminder_type", settings: %{}, schedule: "some schedule"}

  @tag :schema_reminder
  test "Reminder schema metadata" do
    assert Reminder.__schema__(:source) == "reminders"
    assert Reminder.__schema__(:primary_key) == [:id]

    assert Reminder.all_fields() == [:description, :id, :inserted_at, :reminder_type, :schedule, :settings, :updated_at]
  end

  describe "changeset/2" do
    @describetag :schema_reminder
    test "with valid params" do
      changeset = Reminder.changeset(%Reminder{}, @valid_attrs)
      assert changeset.required == [:description, :reminder_type, :schedule]
      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = Reminder.changeset(%Reminder{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
