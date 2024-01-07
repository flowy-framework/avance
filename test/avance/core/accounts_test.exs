defmodule Avance.Core.AccountsTest do
  use Avance.DataCase

  alias Avance.Schemas.Account
  alias Avance.Core.Accounts
  import Avance.Test.Setups

  describe "managing operations with existing data" do
    @describetag :core_accounts
    setup [:setup_account]

    test "get all accounts", %{account: account} do
      assert Accounts.all() == [account]
    end

    test "get last account", %{account: account} do
      assert Accounts.last(1) == [account]
    end

    test "get account by id", %{account: account} do
      assert Accounts.get!(account.id) == account
    end

    test "update account", %{account: account} do
      update_attrs = %{name: "some updated name", logo: "some updated logo"}

      assert {:ok, %Account{} = account} = Accounts.update(account, update_attrs)
      assert account.name == "some updated name"
      assert account.logo == "some updated logo"
    end

    test "change/1", %{account: account} do
      assert %Ecto.Changeset{} = Accounts.change(account)
    end

    test "delete account", %{account: %{id: account_id} = account} do
      assert {:ok, %Account{id: ^account_id}} = Accounts.delete(account)
      assert Accounts.get(account_id) == nil
    end
  end

  setup [:setup_user]

  @tag :core_accounts
  test "create account", %{user: %{id: user_id}} do
    valid_attrs = %{name: "some name", logo: "some logo", owner_id: user_id}

    assert {:ok, %Account{} = account} = Accounts.create(valid_attrs)
    assert account.name == "some name"
    assert account.logo == "some logo"
  end
end
