defmodule Avance.Repo.Migrations.CreateReminders do
  use Ecto.Migration

  def change do
    create table(:reminders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text, null: false
      add :reminder_type, :text, null: false
      add :settings, :map, null: false, default: %{}
      add :schedule, :text, null: false
      add :timezone, :text, null: false
      add :last_run_at, :utc_datetime, null: false
      add :enabled, :boolean, null: false, default: true

      add(:project_id, references(:projects, type: :binary_id), null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
