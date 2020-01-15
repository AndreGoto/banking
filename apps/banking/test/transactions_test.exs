defmodule Banking.TransactionsTest do
  use ExUnit.Case
  alias Banking.{Account, Accounts, Transaction, Transactions, Repo}
  import Ecto.Query
  doctest Banking, import: true

  describe "insert_withdraw_transaction/1" do
    setup do
      {:ok, acc} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, transaction} = Transactions.insert_withdraw_transaction(%{
        amount: 1_000,
        kind: "withdraw",
        account_from_id: acc.id
      })
      [
        acc: acc,
        transaction: transaction
      ]
    end

    test "adds a transaction and update account balance", %{
      acc: acc,
      transaction: transaction
    } do
      query = from account in Account, where: account.id == ^acc.id
      account = Repo.one(query)

      assert account.current_balance == acc.current_balance - transaction[:transaction].amount
    end

    test "do not add a transaction when amount is negative", %{
      acc: acc
    } do
      {:error, _transaction, _, _} = Transactions.insert_withdraw_transaction(%{
        amount: - 10_000,
        kind: "withdraw",
        account_from_id: acc.id
      })

      count_query = from t in Transaction, select: count(t.id)
      transaction = Repo.one(count_query)

      assert Repo.one(count_query) == transaction
    end

    test "do not add a transaction when there is no balance", %{
      acc: acc
    } do
      {:error, _transaction, _, _} = Transactions.insert_withdraw_transaction(%{
        amount: 1_000_000,
        kind: "withdraw",
        account_from_id: acc.id
      })

      count_query = from t in Transaction, select: count(t.id)
      transaction = Repo.one(count_query)

      assert Repo.one(count_query) == transaction
    end
  end

  describe "insert_transfer_transaction/1" do
    test "adds a transfer transaction update account balance" do
      {:ok, acc_from} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, acc_to} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, transaction} = Transactions.insert_transfer_transaction(%{
        amount: 1_000,
        kind: "transfer",
        account_from_id: acc_from.id,
        account_to_id: acc_to.id
      })

      query = from account in Account, where: account.id == ^acc_from.id
      account_from = Repo.one(query)

      query = from account in Account, where: account.id == ^acc_to.id
      account_to = Repo.one(query)

      assert account_from.current_balance == acc_from.current_balance - transaction[:transaction].amount
      assert account_to.current_balance == acc_to.current_balance + transaction[:transaction].amount
    end

    test "do not add a transaction when amount is negative" do
      {:ok, acc_from} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, acc_to} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:error, _transaction, _, _} = Transactions.insert_transfer_transaction(%{
        amount: -1_000,
        kind: "transfer",
        account_from_id: acc_from.id,
        account_to_id: acc_to.id
      })

      count_query = from t in Transaction, select: count(t.id)
      transaction = Repo.one(count_query)

      assert Repo.one(count_query) == transaction
    end

    test "do not add a transaction when there is no balance" do
      {:ok, acc_from} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, acc_to} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:error, _transaction, _, _} = Transactions.insert_transfer_transaction(%{
        amount: 1_000_000,
        kind: "transfer",
        account_from_id: acc_from.id,
        account_to_id: acc_to.id
      })

      count_query = from t in Transaction, select: count(t.id)
      transaction = Repo.one(count_query)

      assert Repo.one(count_query) == transaction
    end

    test "do not add a transaction when receiver account is invalid" do
      {:ok, acc_from} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      assert_raise  Ecto.NoResultsError, fn ->
        Transactions.insert_transfer_transaction(%{
          amount: 1_000,
          kind: "transfer",
          account_from_id: acc_from.id,
          account_to_id: 99999
        })
      end

      count_query = from t in Transaction, select: count(t.id)
      transaction = Repo.one(count_query)

      assert Repo.one(count_query) == transaction
    end
  end
end
