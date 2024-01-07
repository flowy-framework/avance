defmodule Avance.Queries.AccountQuery do
  @moduledoc """
  This module contains the queries for accounts .
  """
  import Ecto.Query

  alias Avance.Schemas.Account
  alias Avance.Repo

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.all()
      [%Account{}, ...]

  """
  def all() do
    base()
    |> Repo.all()
  end

  @doc """
  Returns the last inserted accounts.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.last(3)
      [%Account{}, ...]

  """
  def last(limit) do
    base()
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.get!("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Account{}

  """
  def get!(id) do
    base()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single account.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.get("44bff7b0-c9e4-4d5d-a6f3-61fb2c6dbddf")
      %Account{}

  """
  def get(id) do
    base()
    |> Repo.get(id)
  end

  @doc """
  Creates a account.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.create(%{field: value})
      {:ok, %Account{}}

      iex> Elixir.Avance.Queries.AccountQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a account.

  Raise an error if the Account could not be created.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.create(%{field: value})
      {:ok, %Account{}}

      iex> Elixir.Avance.Queries.AccountQuery.create(%{field: bad_value})
      {:error, ...}

  """
  def create!(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery(account, %{field: new_value})
      {:ok, %Account{}}

      iex> Elixir.Avance.Queries.AccountQuery(account, %{field: bad_value})
      {:error, ...}

  """
  def update(model, attrs) do
    model
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a account.

  Raise an error if the Account could not be updated.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery!(account, %{field: new_value})
      {:ok, %Account{}}

  """
  def update!(model, attrs) do
    model
    |> Account.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery(account)
      {:ok, %Account{}}

  """
  def delete(model) do
    model
    |> Repo.delete()
  end

  @doc """
  Returns a data structure for tracking account changes.

  ## Examples

      iex> Elixir.Avance.Queries.AccountQuery.changeset(account)
      %Todo{...}

  """
  def changeset(model, attrs \\ %{}) do
    model
    |> Account.changeset(attrs)
  end

  @doc false
  def base,
    do:
      from(account in Account,
        as: :account
      )
end
