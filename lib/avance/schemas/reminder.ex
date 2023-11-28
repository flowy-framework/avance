defmodule Avance.Schemas.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "reminders" do
    field :description, :string
    field :reminder_type, :string
    field :settings, :map
    field :schedule, :string

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
