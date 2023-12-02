defmodule Avance.Queries.DigestProjectQuery do
  @moduledoc """
  This module contains the queries for digest_projects .
  """
  import Ecto.Query

  alias Avance.Schemas.DigestProject
  alias Avance.Repo

  @doc """
  Returns the list of digest_projects.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.all()
      [%DigestProject{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted digest_projects.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.last(3)
      [%DigestProject{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single digest_project.

  Raises if the Digest project does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %DigestProject{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single digest_project.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %DigestProject{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a digest_project.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.create(%{field: value})
      {:ok, %DigestProject{}}

      iex> Elixir.Avance.Queries.DigestProjectQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %DigestProject{}
    |> DigestProject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a digest_project.

  Raise an error if the Digest project could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.create(%{field: value})
      {:ok, %DigestProject{}}

      iex> Elixir.Avance.Queries.DigestProjectQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %DigestProject{}
    |> DigestProject.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a digest_project.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery(digest_project, %{field: new_value})
      {:ok, %DigestProject{}}

      iex> Elixir.Avance.Queries.DigestProjectQuery(digest_project, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> DigestProject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a digest_project.

  Raise an error if the Digest project could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery!(digest_project, %{field: new_value})
      {:ok, %DigestProject{}}

  """
  def update!(model, attrs) do
    model
    |> DigestProject.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a DigestProject.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery(digest_project)
      {:ok, %DigestProject{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all digest_projects records.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(DigestProject)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking digest_project changes.

  ## Examples

      iex> Elixir.Avance.Queries.DigestProjectQuery.changeset(digest_project)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> DigestProject.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(digest_project in DigestProject,
        as: :digest_project
      )
end
