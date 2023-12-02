defmodule Avance.Repo.Migrations.CreateDigestProjects do
  use Ecto.Migration

  def change do
    create table(:digest_projects, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :project_id, references(:projects, type: :binary_id), null: false
      add :digest_id, references(:digests, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
