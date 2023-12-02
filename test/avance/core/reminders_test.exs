defmodule Avance.Core.RemindersTest do
  alias Avance.Workers.ReminderWorker
  use Avance.DataCase

  alias Avance.Schemas.Reminder
  alias Avance.Core.Reminders
  alias Avance.Tests.Fixtures.ReminderFixtures
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
      update_attrs = %{
        description: "some updated description",
        reminder_type: :test,
        settings: %{},
        schedule: "0 * * * *"
      }

      assert {:ok, %Reminder{} = reminder} = Reminders.update(reminder, update_attrs)
      assert reminder.description == "some updated description"
      assert reminder.reminder_type == :test
      assert reminder.settings == %{}
      assert reminder.schedule == "0 * * * *"
    end

    test "change/1", %{reminder: reminder} do
      assert %Ecto.Changeset{} = Reminders.change(reminder)
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

  describe "creating reminders" do
    setup [:setup_project]

    @tag :core_reminders
    test "create reminder", %{project: project} do
      valid_attrs = %{
        description: "some description",
        reminder_type: :test,
        settings: %{},
        timezone: "Europe/Madrid",
        schedule: "some schedule",
        project_id: project.id
      }

      assert {:ok, %Reminder{} = reminder} = Reminders.create(valid_attrs)
      assert reminder.description == "some description"
      assert reminder.reminder_type == :test
      assert reminder.settings == %{}
      assert reminder.schedule == "some schedule"
    end
  end

  describe "scheduling reminders" do
    @describetag :core_reminders_schedule
    setup [:setup_project, :setup_reminders, :setup_disabled_reminders]

    test "all", %{reminders: [%{id: first_reminder_id}, %{id: second_reminder_id}]} do
      result = Reminders.schedule()
      assert length(result) == 2
      # Let's run it twice to make sure we don't
      # schedule the same reminder twice
      Reminders.schedule()

      assert [
               %{
                 args: %{"id" => ^second_reminder_id},
                 worker: "Avance.Workers.ReminderWorker"
               },
               %{
                 args: %{"id" => ^first_reminder_id},
                 worker: "Avance.Workers.ReminderWorker"
               }
             ] = all_enqueued(queue: :reminders)
    end

    @tag :core_reminders_next_run
    test "next_run/1" do
      reminder = %Reminder{schedule: "*/2 * * * *", last_run_at: nil}
      now = Timex.now()

      next_run = Reminders.next_run(reminder)
      assert DateTime.after?(next_run, now)

      reminder = %{reminder | last_run_at: next_run}
      next_next_run = Reminders.next_run(reminder)
      assert DateTime.after?(next_next_run, next_run)
    end

    @tag :core_reminders_update_last_run_at
    test "update_last_run_at/2", %{reminder: reminder} do
      date = ~U[2023-12-02 13:48:00.763298Z]
      assert Reminders.update_last_run_at!(reminder, date)
    end

    @tag :core_reminders_schedule_one
    test "one", %{reminders: [first_reminder | _last]} do
      first_reminder
      |> Reminders.schedule()

      assert_enqueued worker: ReminderWorker, args: %{id: first_reminder.id}
      assert %{success: 1, failure: 0} = Oban.drain_queue(queue: :reminders, with_scheduled: true)

      %{last_run_at: last_run_at} = reminder = Reminders.get!(first_reminder.id)
      assert(last_run_at != nil)
      # assert({:ok, %{conflict?: true}} = perform_job(ReminderWorker, %{id: first_reminder.id}))
      # assert_enqueued worker: ReminderWorker, args: %{id: first_reminder.id}
    end
  end

  def setup_reminders(%{project: %{id: project_id}} = context) do
    [first_reminder, _] =
      reminders =
      1..2
      |> Enum.map(fn _ ->
        ReminderFixtures.reminder_fixture(%{enabled: true, project_id: project_id})
      end)

    context
    |> Map.put(:reminders, reminders)
    # for convinience just save the first reminder
    |> Map.put(:reminder, first_reminder)
  end

  def setup_disabled_reminders(%{project: %{id: project_id}} = context) do
    reminders =
      1..2
      |> Enum.map(fn _ ->
        ReminderFixtures.reminder_fixture(%{enabled: false, project_id: project_id})
      end)

    context
    |> Map.put(:disabled_reminders, reminders)
  end
end
