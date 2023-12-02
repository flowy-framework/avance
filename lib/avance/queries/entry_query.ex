defmodule Avance.Queries.EntryQuery do
  @moduledoc """
  This module contains the queries for entries.
  """
  import Ecto.Query

  alias Avance.Schemas.Entry
  alias Avance.Repo

  @doc """
  Returns the list of entries.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.all()
      [%Entry{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted entries.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.last(3)
      [%Entry{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single entry.

  Raises if the Entry does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Entry{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single entry.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Entry{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a entry.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.create(%{field: value})
      {:ok, %Entry{}}

      iex> Elixir.Avance.Queries.EntryQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a entry.

  Raise an error if the Entry could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.create(%{field: value})
      {:ok, %Entry{}}

      iex> Elixir.Avance.Queries.EntryQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> Elixir.Avance.Queries.EntryQuery(entry, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a entry.

  Raise an error if the Entry could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery!(entry, %{field: new_value})
      {:ok, %Entry{}}

  """
  def update!(model, attrs) do
    model
    |> Entry.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Entry.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery(entry)
      {:ok, %Entry{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all entries records.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(Entry)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking entry changes.

  ## Examples

      iex> Elixir.Avance.Queries.EntryQuery.changeset(entry)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Entry.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(entry in Entry,
        as: :entry
      )
end
