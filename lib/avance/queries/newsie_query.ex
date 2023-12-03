defmodule Avance.Queries.NewsieQuery do
  @moduledoc """
  This module contains the queries for newsies .
  """
  import Ecto.Query

  alias Avance.Schemas.Newsie
  alias Avance.Repo

  @doc """
  Returns the list of newsies.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.all()
      [%Newsie{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted newsies.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.last(3)
      [%Newsie{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single newsie.

  Raises if the Newsie does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Newsie{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single newsie.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Newsie{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a newsie.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.create(%{field: value})
      {:ok, %Newsie{}}

      iex> Elixir.Avance.Queries.NewsieQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Newsie{}
    |> Newsie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a newsie.

  Raise an error if the Newsie could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.create(%{field: value})
      {:ok, %Newsie{}}

      iex> Elixir.Avance.Queries.NewsieQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Newsie{}
    |> Newsie.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a newsie.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery(newsie, %{field: new_value})
      {:ok, %Newsie{}}

      iex> Elixir.Avance.Queries.NewsieQuery(newsie, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Newsie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a newsie.

  Raise an error if the Newsie could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery!(newsie, %{field: new_value})
      {:ok, %Newsie{}}

  """
  def update!(model, attrs) do
    model
    |> Newsie.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Newsie.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery(newsie)
      {:ok, %Newsie{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all newsies records.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(Newsie)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking newsie changes.

  ## Examples

      iex> Elixir.Avance.Queries.NewsieQuery.changeset(newsie)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Newsie.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(newsie in Newsie,
        as: :newsie
      )
end
