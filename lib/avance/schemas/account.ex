defmodule Avance.Schemas.Account do
  @moduledoc """
  The schema for the accounts table.
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
  schema "accounts" do
    field :name, :string
    field :logo, :string

    belongs_to :owner, Avance.Schemas.User
    has_many :projects, Avance.Schemas.Project

    timestamps(type: :utc_datetime)
  end

  @required_fields [:name, :logo, :owner_id]
  @optional_fields []

  @doc """
  Returns all fields of the schema.
  """
  @spec all_fields() :: any()
  def all_fields() do
    __MODULE__.__schema__(:fields) |> Enum.sort()
  end

  @doc false
  @spec changeset(Avance.Schemas.Account.t(), map()) :: Ecto.Changeset.t()
  def changeset(account, attrs) do
    account
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
