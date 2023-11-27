defmodule Avance.Core.Reminders do
  alias Avance.Queries.ReminderQuery

  defdelegate all, to: ReminderQuery
  defdelegate get(id), to: ReminderQuery
  defdelegate last(limit), to: ReminderQuery
  defdelegate get!(id), to: ReminderQuery
  defdelegate update!(mode, attrs), to: ReminderQuery
  defdelegate update(mode, attrs), to: ReminderQuery
  defdelegate delete(mode), to: ReminderQuery
  defdelegate delete_all(), to: ReminderQuery
  defdelegate create(attrs), to: ReminderQuery
  defdelegate change(model, attrs \\ %{}), to: ReminderQuery, as: :changeset
end
