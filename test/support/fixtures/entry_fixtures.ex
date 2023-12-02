defmodule Avance.Tests.Fixtures.EntryFixtures do
  @moduledoc """
  "Entry" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Entry

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{description: "some description"}
  end
end
