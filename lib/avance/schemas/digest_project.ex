defmodule Avance.Schemas.DigestProject do
  @moduledoc """
  This module contains the schema for the DigestProject model.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: binary(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "digest_projects" do
    belongs_to :digest, Avance.Schemas.Digest
    belongs_to :project, Avance.Schemas.Project

    timestamps(type: :utc_datetime)
  end

  @required_fields [:digest_id, :project_id, :digest_id]
  @optional_fields []

  @doc """
  Returns all fields of the schema.
  """
  @spec all_fields() :: any()
  def all_fields() do
    __MODULE__.__schema__(:fields) |> Enum.sort()
  end

  @doc false
  @spec changeset(Avance.Schemas.DigestProject.t(), map()) :: Ecto.Changeset.t()
  def changeset(digest_project, attrs) do
    digest_project
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
