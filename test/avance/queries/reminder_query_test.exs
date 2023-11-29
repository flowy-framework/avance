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
      update_attrs = %{
        description: "some updated description",
        reminder_type: :test,
        settings: %{},
        schedule: "0 * * * *"
      }

      assert {:ok, %Reminder{} = reminder} = ReminderQuery.update(reminder, update_attrs)
      assert reminder.description == "some updated description"
      assert reminder.reminder_type == :test
      assert reminder.settings == %{}
      assert reminder.schedule == "0 * * * *"
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

    @tag :reminder_query_search
    test "search/1 returns no reminders when filter doesn't match" do
      assert ReminderQuery.search(%{enabled: false}) == []
    end

    @tag :reminder_query_search
    test "search/1 returns reminders by filter", %{reminder: %{id: reminder_id}} do
      assert [%{id: ^reminder_id}] = ReminderQuery.search(%{enabled: true})
    end
  end

  describe "create reminders" do
    setup [:setup_project]

    @tag :reminder_query
    test "create reminder", %{project: project} do
      valid_attrs = %{
        description: "some description",
        reminder_type: :test,
        settings: %{},
        timezone: "Europe/Madrid",
        schedule: "* * * * *",
        project_id: project.id
      }

      assert {:ok, %Reminder{} = reminder} = ReminderQuery.create(valid_attrs)
      assert reminder.description == "some description"
      assert reminder.reminder_type == :test
      assert reminder.settings == %{}
      assert reminder.schedule == "* * * * *"
    end
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ReminderQuery.create(@invalid_attrs)
  end
end
