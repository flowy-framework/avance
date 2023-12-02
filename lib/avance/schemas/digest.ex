defmodule Avance.Schemas.Digest do
  @moduledoc """
  This module contains the schema for the Digest model.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: binary(),
          schedule: String.t(),
          timezone: String.t(),
          last_run_at: DateTime.t(),
          enabled: boolean(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "digests" do
    field :description, :string
    field :schedule, :string
    field :timezone, :string, default: "Europe/Madrid"
    field :enabled, :boolean, default: true
    field :last_run_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @required_fields [:description, :schedule, :timezone]
  @optional_fields [:enabled, :last_run_at]

  @doc """
  Returns all fields of the schema.
  """
  @spec all_fields() :: any()
  def all_fields() do
    __MODULE__.__schema__(:fields) |> Enum.sort()
  end

  @doc false
  @spec changeset(Avance.Schemas.Digest.t(), map()) :: Ecto.Changeset.t()
  def changeset(digest, attrs) do
    digest
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
