defmodule Avance.Schemas.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  @reminder_types [:slack]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reminders" do
    field :description, :string
    field :reminder_type, Ecto.Enum, values: @reminder_types
    field :settings, :map
    field :schedule, :string

    belongs_to :project, Avance.Schemas.Project

    timestamps(type: :utc_datetime)
  end

  @required_fields [:description, :reminder_type, :schedule]
  @optional_fields [:settings]

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
  end
end