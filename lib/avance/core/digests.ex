defmodule Avance.Core.Digests do
  @moduledoc """
  This module contains the business logic for Digests.
  """

  alias Avance.Queries.DigestQuery

  defdelegate all, to: DigestQuery
  defdelegate get(id), to: DigestQuery
  defdelegate last(limit), to: DigestQuery
  defdelegate get!(id), to: DigestQuery
  defdelegate update!(mode, attrs), to: DigestQuery
  defdelegate update(mode, attrs), to: DigestQuery
  defdelegate delete(mode), to: DigestQuery
  defdelegate delete_all(), to: DigestQuery
  defdelegate create(attrs), to: DigestQuery
  defdelegate change(model, attrs \\ %{}), to: DigestQuery, as: :changeset
end
