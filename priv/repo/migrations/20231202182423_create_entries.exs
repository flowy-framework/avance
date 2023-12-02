defmodule Avance.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text

      add :project_id, references(:projects, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
