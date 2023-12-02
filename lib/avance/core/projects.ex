defmodule Avance.Core.Projects do
  @moduledoc """
  This module contains the business logic for projects.
  """
  alias Avance.Queries.ProjectQuery

  defdelegate all, to: ProjectQuery
  defdelegate get(id), to: ProjectQuery
  defdelegate last(limit), to: ProjectQuery
  defdelegate get!(id), to: ProjectQuery
  defdelegate update!(mode, attrs), to: ProjectQuery
  defdelegate update(mode, attrs), to: ProjectQuery
  defdelegate delete(mode), to: ProjectQuery
  defdelegate delete_all(), to: ProjectQuery
  defdelegate create(attrs), to: ProjectQuery
  defdelegate change(model, attrs \\ %{}), to: ProjectQuery, as: :changeset
end
