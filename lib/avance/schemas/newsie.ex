defmodule Avance.Schemas.Newsie do
  @moduledoc """
  This module defines the schema for the Newsie entity.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: binary(),
          description: String.t(),
          newsie_type: :slack,
          settings: map(),
          schedule: String.t(),
          enabled: boolean(),
          digest_id: binary(),
          timezone: String.t(),
          last_run_at: DateTime.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "newsies" do
    field :enabled, :boolean, default: false
    field :name, :string
    field :description, :string
    field :settings, :map
    field :schedule, :string
    field :timezone, :string
    field :newsie_type, Ecto.Enum, values: [:slack, :test]
    field :last_run_at, :utc_datetime
    belongs_to :digest, Avance.Schemas.Digest

    timestamps(type: :utc_datetime)
  end

  @required_fields [
    :description,
    :schedule,
    :enabled,
    :timezone,
    :newsie_type,
    :name,
    :digest_id
  ]
  @optional_fields [:settings, :last_run_at]

  @doc """
  Returns all fields of the schema.
  """
  @spec all_fields() :: any()
  def all_fields() do
    __MODULE__.__schema__(:fields) |> Enum.sort()
  end

  @doc false
  @spec changeset(Avance.Schemas.Newsie.t(), map()) :: Ecto.Changeset.t()
  def changeset(newsie, attrs) do
    newsie
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> set_last_run_at()
  end

  defp set_last_run_at(%Ecto.Changeset{changes: %{last_run_at: _}} = changeset), do: changeset

  defp set_last_run_at(%Ecto.Changeset{} = changeset) do
    changeset
    |> put_change(:last_run_at, DateTime.truncate(DateTime.utc_now(), :second))
  end
end
