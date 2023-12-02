defmodule Avance.Queries.ProjectQuery do
  @moduledoc """
  This module contains the queries for projects.
  """
  import Ecto.Query

  alias Avance.Schemas.Project
  alias Avance.Repo

  @doc """
  Returns the list of projects.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.all()
      [%Project{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted projects.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.last(3)
      [%Project{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single project.

  Raises if the Project does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Project{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single project.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Project{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a project.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.create(%{field: value})
      {:ok, %Project{}}

      iex> Elixir.Avance.Queries.ProjectQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a project.

  Raise an error if the Project could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.create(%{field: value})
      {:ok, %Project{}}

      iex> Elixir.Avance.Queries.ProjectQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery(project, %{field: new_value})
      {:ok, %Project{}}

      iex> Elixir.Avance.Queries.ProjectQuery(project, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a project.

  Raise an error if the Project could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery!(project, %{field: new_value})
      {:ok, %Project{}}

  """
  def update!(model, attrs) do
    model
    |> Project.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery(project)
      {:ok, %Project{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Deletes all projects records.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.delete_all()
      {:ok, 1}

  """
  def delete_all() do
    from(Project)
    |> Repo.delete_all()
  end

  @doc """
  Returns a data structure for tracking project changes.

  ## Examples

      iex> Elixir.Avance.Queries.ProjectQuery.changeset(project)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Project.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(project in Project,
        as: :project
      )
end
