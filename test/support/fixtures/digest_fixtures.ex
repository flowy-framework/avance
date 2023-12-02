defmodule Avance.Tests.Fixtures.DigestFixtures do
  @moduledoc """
  "Digest" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Digest

  @doc """
  Generate a digest.
  """
  def digest_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Digest{}
    |> Digest.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{description: "some description", schedule: "* * * * *", timezone: "Europe/Madrid"}
  end
end
