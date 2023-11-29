defmodule Avance.Core.Servers.ReminderServer do
  use GenServer

  alias Avance.Core.Reminders

  @name {:global, __MODULE__}

  ##### Public API #####
  def schedule(reminder) do
    GenServer.cast(@name, {:schedule, reminder})
  end

  ##### Callbacks #####

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: @name)
  end

  @impl true
  def init(args) do
    {:ok, args, {:continue, :load_reminders}}
  end

  @impl true
  def handle_continue(:load_reminders, reminders) do
    # TODO: Maybe we want to store which reminders has
    # been sent to avoid sending them again.
    Reminders.schedule()
    {:noreply, reminders}
  end

  @impl true
  def handle_cast({:schedule, reminder}, _state) do
    Reminders.schedule(reminder)
    {:noreply, reminder}
  end
end
