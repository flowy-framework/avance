defmodule Avance.Repo.Migrations.CreateNewsies do
  use Ecto.Migration

  def change do
    create table(:newsies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :settings, :map, null: false
      add :schedule, :text, null: false
      add :enabled, :boolean, default: false, null: false
      add :timezone, :text, null: false
      add :newsie_type, :text, null: false
      add :name, :text, null: false
      add :last_run_at, :utc_datetime, null: false

      add :digest_id, references(:digests, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
