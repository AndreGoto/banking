defmodule Banking.AccountsTest do
  use ExUnit.Case
  alias Banking.{Account, Accounts, Repo}
  import Ecto.Query
  doctest Banking, import: true

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "insert_account/1" do
    test "adds an Account to the database" do
      count_query = from i in Account, select: count(i.id)
      before_count = Repo.one(count_query)
      {:ok, _account} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      assert Repo.one(count_query) == before_count + 1
    end
  end

  describe "get_by_id/1" do
    test "return an account" do
      {:ok, account} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      {:ok, acc} = Accounts.get_by_id(account.id)

      assert acc.id  == account.id
    end
  end
end
