defmodule Avance.Repo.Migrations.CreateReminders do
  use Ecto.Migration

  def change do
    create table(:reminders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :reminder_type, :text
      add :settings, :map
      add :schedule, :text

      add(:project_id, references(:projects, type: :binary_id))

      timestamps(type: :utc_datetime)
    end
  end
end
