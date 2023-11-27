defmodule Avance.Test.Setups do
  alias Avance.Tests.Fixtures.{ProjectFixtures, ReminderFixtures}

  def setup_reminder(context) do
    reminder =
      Map.get(context, :project, setup_project(context))
      |> ReminderFixtures.reminder_fixture()

    context
    |> add_to_context(%{reminder: reminder})
  end

  def setup_project(context) do
    project = ProjectFixtures.project_fixture()

    context
    |> add_to_context(%{project: project})
  end

  defp add_to_context(context, attrs) do
    context
    |> Enum.into(attrs)
  end
end
