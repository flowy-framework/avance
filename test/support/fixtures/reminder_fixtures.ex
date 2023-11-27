defmodule Avance.Tests.Fixtures.ReminderFixtures do
  @moduledoc """
  "Reminder" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Reminder

  @doc """
  Generate a reminder.
  """
  def reminder_fixture(project, attrs \\ %{}) do
    attrs = default_attrs(project) |> Map.merge(attrs)

    %Reminder{}
    |> Reminder.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs(%{id: id}) do
    %{
      project_id: id,
      description: "some description",
      reminder_type: :slack,
      settings: %{},
      schedule: "0 9 * * 1-5"
    }
  end
end
