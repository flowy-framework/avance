defmodule Avance.Tests.Fixtures.DigestProjectFixtures do
  @moduledoc """
  "Digest project" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.DigestProject

  @doc """
  Generate a digest_project.
  """
  def digest_project_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %DigestProject{}
    |> DigestProject.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{description: "some description"}
  end
end
