defmodule Avance.Queries.ReminderQuery do
  import Ecto.Query

  alias Avance.Schemas.Reminder
  alias Avance.Repo

  @doc """
  Returns the list of reminders.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.all()
      [%Reminder{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted reminders.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.last(3)
      [%Reminder{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single reminder.

  Raises if the Reminder does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Reminder{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single reminder.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Reminder{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a reminder.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.create(%{field: value})
      {:ok, %Reminder{}}

      iex> Elixir.Avance.Queries.ReminderQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Reminder{}
    |> Reminder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a reminder.

  Raise an error if the Reminder could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.create(%{field: value})
      {:ok, %Reminder{}}

      iex> Elixir.Avance.Queries.ReminderQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Reminder{}
    |> Reminder.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a reminder.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery(reminder, %{field: new_value})
      {:ok, %Reminder{}}

      iex> Elixir.Avance.Queries.ReminderQuery(reminder, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Reminder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a reminder.

  Raise an error if the Reminder could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery!(reminder, %{field: new_value})
      {:ok, %Reminder{}}

  """
  def update!(model, attrs) do
    model
    |> Reminder.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Reminder.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery(reminder)
      {:ok, %Reminder{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all reminders records.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(Reminder)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking reminder changes.

  ## Examples

      iex> Elixir.Avance.Queries.ReminderQuery.changeset(reminder)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Reminder.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(reminder in Reminder,
        as: :reminder
      )
end
