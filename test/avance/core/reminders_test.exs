defmodule Avance.Core.RemindersTest do
  use Avance.DataCase

  alias Avance.Schemas.Reminder
  alias Avance.Core.Reminders
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_reminders
    setup [:setup_reminder]

    test "get all reminders", %{reminder: reminder} do
      assert Reminders.all() == [reminder]
    end

    test "get last reminder", %{reminder: reminder} do
      assert Reminders.last(1) == [reminder]
    end

    test "get reminder by id", %{reminder: reminder} do
      assert Reminders.get!(reminder.id) == reminder
    end

    test "update reminder", %{reminder: reminder} do
      attrs = %{name: "Updated Vendor"}
      assert {:ok, %Reminder{name: "Updated Vendor"}} = Reminders.update(reminder, attrs)
    end

    test "change/1", %{reminder: reminder} do
      assert %Ecto.Changeset{changes: %{name: "New name"}} =
               Reminders.change(reminder, %{name: "New name"})
    end

    test "delete reminder", %{reminder: %{id: reminder_id} = reminder} do
      assert {:ok, %Reminder{id: ^reminder_id}} = Reminders.delete(reminder)
      assert Reminders.get(reminder_id) == nil
    end

    test "delete all reminders" do
      assert Reminders.delete_all() == {1, nil}
      assert Reminders.all() == []
    end
  end

  @tag :core_reminders
  test "create reminder" do
    valid_attrs = %{
      description: "some description",
      reminder_type: "some reminder_type",
      settings: %{},
      schedule: "some schedule"
    }

    assert {:ok, %Reminder{} = reminder} = Reminders.create(valid_attrs)
    assert reminder.description == "some description"
    assert reminder.reminder_type == "some reminder_type"
    assert reminder.settings == %{}
    assert reminder.schedule == "some schedule"
  end
end
