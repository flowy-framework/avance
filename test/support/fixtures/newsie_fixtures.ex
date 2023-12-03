defmodule Avance.Tests.Fixtures.NewsieFixtures do
  @moduledoc """
  "Newsie" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Newsie

  @doc """
  Generate a newsie.
  """
  def newsie_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Newsie{}
    |> Newsie.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{
      enabled: true,
      name: "some name",
      description: "some description",
      settings: %{},
      schedule: "* * * * *",
      timezone: "Europe/Madrid",
      newsie_type: :test
    }
  end
end
