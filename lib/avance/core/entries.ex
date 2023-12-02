defmodule Avance.Core.Entries do
  @moduledoc """
  This module contains the business logic for <%= schema.human_plural %>.
  """

  alias Avance.Queries.EntryQuery

  defdelegate all, to: EntryQuery
  defdelegate get(id), to: EntryQuery
  defdelegate last(limit), to: EntryQuery
  defdelegate get!(id), to: EntryQuery
  defdelegate update!(mode, attrs), to: EntryQuery
  defdelegate update(mode, attrs), to: EntryQuery
  defdelegate delete(mode), to: EntryQuery
  defdelegate delete_all(), to: EntryQuery
  defdelegate create(attrs), to: EntryQuery
  defdelegate change(model, attrs \\ %{}), to: EntryQuery, as: :changeset
end
