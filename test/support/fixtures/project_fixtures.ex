defmodule Avance.Tests.Fixtures.ProjectFixtures do
  @moduledoc """
  "Project" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Project

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{name: "some name", description: "some description"}
  end
end
