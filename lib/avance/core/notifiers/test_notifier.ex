defmodule Avance.Core.Notifiers.TestNotifier do
  @behaviour Avance.Core.Notifiers.Notifier

  alias Avance.Schemas.Reminder

  @impl true
  def notify(%Reminder{description: description}) do
    {:ok, description}
  end
end
