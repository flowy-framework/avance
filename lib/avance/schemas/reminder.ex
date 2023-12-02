defmodule Avance.Schemas.Reminder do
  @moduledoc """
  This schema represents a reminder.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: binary(),
          description: String.t(),
          reminder_type: :slack,
          settings: map(),
          schedule: String.t(),
          enabled: boolean(),
          project_id: binary(),
          timezone: String.t(),
          last_run_at: DateTime.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @reminder_types [:slack, :test]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "reminders" do
    field :description, :string
    field :reminder_type, Ecto.Enum, values: @reminder_types
    field :settings, :map
    field :schedule, :string
    field :timezone, :string, default: "Europe/Madrid"
    field :enabled, :boolean, default: true
    field :last_run_at, :utc_datetime

    belongs_to :project, Avance.Schemas.Project

    timestamps(type: :utc_datetime)
  end

  @required_fields [:description, :reminder_type, :schedule, :project_id, :timezone]
  @optional_fields [:settings, :enabled, :last_run_at]

  @doc """
  Returns all fields of the schema.
  """
  @spec all_fields() :: any()
  def all_fields() do
    __MODULE__.__schema__(:fields) |> Enum.sort()
  end

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> set_last_run_at()

    # TODO: Add validation for schedule, we can use
    # CronConverter.valid?/1 to check if the schedule is valid.
    # Also validate that we don't have notifiers running every minute,
    # I think we should have at least 10 mins between each run.
  end

  defp set_last_run_at(%Ecto.Changeset{changes: %{last_run_at: _}} = changeset), do: changeset

  defp set_last_run_at(%Ecto.Changeset{} = changeset) do
    changeset
    |> put_change(:last_run_at, DateTime.truncate(DateTime.utc_now(), :second))
  end
end
