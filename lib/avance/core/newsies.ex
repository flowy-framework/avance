defmodule Avance.Core.Newsies do
  @moduledoc """
  This module contains the business logic for Newsies.
  """

  alias Avance.Queries.NewsieQuery

  defdelegate all, to: NewsieQuery
  defdelegate get(id), to: NewsieQuery
  defdelegate last(limit), to: NewsieQuery
  defdelegate get!(id), to: NewsieQuery
  defdelegate update!(mode, attrs), to: NewsieQuery
  defdelegate update(mode, attrs), to: NewsieQuery
  defdelegate delete(mode), to: NewsieQuery
  defdelegate delete_all(), to: NewsieQuery
  defdelegate create(attrs), to: NewsieQuery
  defdelegate change(model, attrs \\ %{}), to: NewsieQuery, as: :changeset
end
