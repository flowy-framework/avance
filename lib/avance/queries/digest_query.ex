defmodule Avance.Queries.DigestQuery do
  @moduledoc """
  This module contains the queries for digests .
  """
  import Ecto.Query

  alias Avance.Schemas.Digest
  alias Avance.Repo

  @doc """
  Returns the list of digests.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.all()
      [%Digest{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted digests.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.last(3)
      [%Digest{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single digest.

  Raises if the Digest does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Digest{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single digest.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Digest{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a digest.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.create(%{field: value})
      {:ok, %Digest{}}

      iex> Elixir.Avance.Queries.DigestQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Digest{}
    |> Digest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a digest.

  Raise an error if the Digest could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.create(%{field: value})
      {:ok, %Digest{}}

      iex> Elixir.Avance.Queries.DigestQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Digest{}
    |> Digest.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a digest.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery(digest, %{field: new_value})
      {:ok, %Digest{}}

      iex> Elixir.Avance.Queries.DigestQuery(digest, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Digest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a digest.

  Raise an error if the Digest could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery!(digest, %{field: new_value})
      {:ok, %Digest{}}

  """
  def update!(model, attrs) do
    model
    |> Digest.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Digest.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery(digest)
      {:ok, %Digest{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all digests records.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(Digest)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking digest changes.

  ## Examples

      iex> Elixir.Avance.Queries.DigestQuery.changeset(digest)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Digest.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(digest in Digest,
        as: :digest
      )
end
