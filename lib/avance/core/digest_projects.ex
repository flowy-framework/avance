defmodule Avance.Core.DigestProjects do
  @moduledoc """
  This module contains the business logic for Digest projects.
  """

  alias Avance.Queries.DigestProjectQuery

  defdelegate all, to: DigestProjectQuery
  defdelegate get(id), to: DigestProjectQuery
  defdelegate last(limit), to: DigestProjectQuery
  defdelegate get!(id), to: DigestProjectQuery
  defdelegate update!(mode, attrs), to: DigestProjectQuery
  defdelegate update(mode, attrs), to: DigestProjectQuery
  defdelegate delete(mode), to: DigestProjectQuery
  defdelegate delete_all(), to: DigestProjectQuery
  defdelegate create(attrs), to: DigestProjectQuery
  defdelegate change(model, attrs \\ %{}), to: DigestProjectQuery, as: :changeset
end
