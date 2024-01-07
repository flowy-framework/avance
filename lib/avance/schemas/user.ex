defmodule Avance.Schemas.User do
  @moduledoc """
  The schema for the users table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: binary(),
          email: String.t(),
          avatar_url: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}
  schema "users" do
    field(:email, :string)
    field(:avatar_url, :string)
    field(:first_name, :string)
    field(:last_name, :string)

    timestamps(type: :utc_datetime)
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:validate_email` - Validates the uniqueness of the email, in case
      you don't want to validate the uniqueness of the email (like when
      using this changeset for validations on a LiveView form before
      submitting the form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :avatar_url])
    |> validate_email(opts)
  end

  defp validate_email(changeset, opts) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> maybe_validate_unique_email(opts)
  end

  defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_email, true) do
      changeset
      |> unsafe_validate_unique(:email, Avance.Repo)
      |> unique_constraint(:email)
    else
      changeset
    end
  end

  @doc """
  Returns the default avatar URL for the given user.
  """
  @spec default_avatar_url(Avance.Schemas.User.t()) :: String.t()
  def default_avatar_url(%__MODULE__{avatar_url: avatar_url}) do
    avatar_url || "/images/default-user-avatar.png"
  end

  @doc """
  Returns the full name of the given user.
  """
  @spec full_name(Avance.Schemas.User.t()) :: nil | String.t()
  def full_name(%{first_name: "", last_name: ""}), do: nil
  def full_name(%{first_name: nil, last_name: nil}), do: nil

  def full_name(%{first_name: first_name, last_name: last_name}) do
    "#{first_name} #{last_name}"
  end
end
