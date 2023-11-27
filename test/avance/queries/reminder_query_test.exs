defmodule Avance.Queries.ReminderQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Reminder
  alias Avance.Queries.ReminderQuery
  import Avance.Test.Setups

  @invalid_attrs %{description: nil, reminder_type: nil, settings: nil, schedule: nil}

  describe "managing operations with existing data" do
    @describetag :reminder_query
    setup [:setup_reminder]

    test "get all reminders", %{reminder: reminder} do
      assert Avance.Queries.ReminderQuery.all() == [reminder]
    end

    test "get last reminder", %{reminder: reminder} do
      assert Avance.Queries.ReminderQuery.last(1) == [reminder]
    end

    test "get reminder by id", %{reminder: reminder} do
      assert Avance.Queries.ReminderQuery.get!(reminder.id) == reminder
    end

    test "update reminder", %{reminder: reminder} do
      update_attrs = %{description: "some updated description", reminder_type: "some updated reminder_type", settings: %{}, schedule: "some updated schedule"}

      assert {:ok, %Reminder{} = reminder} = ReminderQuery.update(reminder, update_attrs)
      assert reminder.description == "some updated description"
      assert reminder.reminder_type == "some updated reminder_type"
      assert reminder.settings == %{}
      assert reminder.schedule == "some updated schedule"
    end

    test "delete reminder", %{reminder: %{id: reminder_id} = reminder} do
      assert {:ok, %Reminder{id: ^reminder_id}} = Avance.Queries.ReminderQuery.delete(reminder)
      assert Avance.Queries.ReminderQuery.get(reminder_id) == nil
    end

    test "delete all reminders" do
      assert Avance.Queries.ReminderQuery.delete_all() == {1, nil}
      assert Avance.Queries.ReminderQuery.all() == []
    end

    test "changeset/1 returns a reminder changeset", %{reminder: reminder} do
      assert %Ecto.Changeset{} = ReminderQuery.changeset(reminder)
    end
  end

  @tag :reminder_query
  test "create reminder" do
    valid_attrs = %{description: "some description", reminder_type: "some reminder_type", settings: %{}, schedule: "some schedule"}

    assert {:ok, %Reminder{} = reminder} = ReminderQuery.create(valid_attrs)
    assert reminder.description == "some description"
    assert reminder.reminder_type == "some reminder_type"
    assert reminder.settings == %{}
    assert reminder.schedule == "some schedule"
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ReminderQuery.create(@invalid_attrs)
  end
end
