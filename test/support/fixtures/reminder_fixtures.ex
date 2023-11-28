defmodule Avance.Tests.Fixtures.ReminderFixtures do
  @moduledoc """
  "Reminder" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Reminder

  @doc """
  Generate a reminder.
  """
  def reminder_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Reminder{}
    |> Reminder.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{description: "some description", reminder_type: "some reminder_type", settings: %{}, schedule: "some schedule"}
  end
end
