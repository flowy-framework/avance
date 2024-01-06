defmodule Avance.Tests.Fixtures.AccountFixtures do
  @moduledoc """
  "Account" fixtures.
  """

  alias Avance.Repo
  alias Avance.Schemas.Account

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    attrs = default_attrs() |> Map.merge(attrs)

    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert!()
  end

  def default_attrs do
    %{name: "some name", logo: "some logo"}
  end
end
