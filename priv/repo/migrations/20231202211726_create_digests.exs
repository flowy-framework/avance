defmodule Avance.Repo.Migrations.CreateDigests do
  use Ecto.Migration

  def change do
    create table(:digests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text, null: false
      add :schedule, :text, null: false
      add :enabled, :boolean, default: true, null: false
      add :timezone, :text, null: false
      add :last_run_at, :utc_datetime, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
