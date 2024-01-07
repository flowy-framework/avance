defmodule Avance.Core.Accounts do
  @moduledoc """
  This module contains the business logic for Accounts.
  """

  alias Avance.Queries.AccountQuery

  defdelegate all, to: AccountQuery
  defdelegate get(id), to: AccountQuery
  defdelegate last(limit), to: AccountQuery
  defdelegate get!(id), to: AccountQuery
  defdelegate update!(model, attrs), to: AccountQuery
  defdelegate update(model, attrs), to: AccountQuery
  defdelegate delete(model), to: AccountQuery
  defdelegate create(attrs), to: AccountQuery
  defdelegate create!(attrs), to: AccountQuery
  defdelegate change(model, attrs \\ %{}), to: AccountQuery, as: :changeset
end
