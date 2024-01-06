defmodule Avance.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text
      add :logo, :text
      add :owner_id, references(:users, type: :uuid), null: false

      timestamps(type: :utc_datetime)
    end

    alter table(:projects) do
      add :account_id, references(:accounts, on_delete: :delete_all, type: :uuid), null: false
    end
  end
end
