defmodule Avance.Test.Setups do
  alias Avance.Tests.Fixtures.{ProjectFixtures, ReminderFixtures}

  def setup_reminder(%{project: project} = context) do
    %{id: project_id} = project

    reminder =
      %{project_id: project_id}
      |> ReminderFixtures.reminder_fixture()

    context
    |> add_to_context(%{reminder: reminder})
    |> add_to_context(%{project: project})
  end

  def setup_reminder(context) do
    %{project: %{id: project_id} = project} = setup_project(context)

    reminder =
      %{project_id: project_id}
      |> ReminderFixtures.reminder_fixture()

    context
    |> add_to_context(%{reminder: reminder})
    |> add_to_context(%{project: project})
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
