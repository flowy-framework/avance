defmodule Avance.Queries.AccountQueryTest do
  use Avance.DataCase

  alias Avance.Schemas.Account
  alias Avance.Queries.AccountQuery
  import Avance.Test.Setups

  @invalid_attrs %{name: nil, logo: nil}

  describe "managing operations with existing data" do
    @describetag :account_query
    setup [:setup_account]

    test "get all accounts", %{account: account} do
      assert Avance.Queries.AccountQuery.all() == [account]
    end

    test "get last account", %{account: account} do
      assert Avance.Queries.AccountQuery.last(1) == [account]
    end

    test "get account by id", %{account: account} do
      assert Avance.Queries.AccountQuery.get!(account.id) == account
    end

    test "update account", %{account: account} do
      update_attrs = %{name: "some updated name", logo: "some updated logo"}

      assert {:ok, %Account{} = account} = AccountQuery.update(account, update_attrs)
      assert account.name == "some updated name"
      assert account.logo == "some updated logo"
    end

    test "delete account", %{account: %{id: account_id} = account} do
      assert {:ok, %Account{id: ^account_id}} = Avance.Queries.AccountQuery.delete(account)
      assert Avance.Queries.AccountQuery.get(account_id) == nil
    end

    test "changeset/1 returns a account changeset", %{account: account} do
      assert %Ecto.Changeset{} = AccountQuery.changeset(account)
    end
  end

  setup [:setup_user]

  @tag :account_query
  test "create account", %{user: %{id: user_id}} do
    valid_attrs = %{name: "some name", logo: "some logo", owner_id: user_id}

    assert {:ok, %Account{} = account} = AccountQuery.create(valid_attrs)
    assert account.name == "some name"
    assert account.logo == "some logo"
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = AccountQuery.create(@invalid_attrs)
  end
end
