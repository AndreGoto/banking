defmodule Banking.Transactions do

  alias Banking.{Transaction, Account}
  alias Ecto.Multi

  @repo Banking.Repo

  def insert_withdraw_transaction(params) do
    multi = 
      Multi.new()
      |> Multi.insert(:transaction, Transaction.changeset(%Transaction{}, params))
      |> Multi.run(:account, fn _repo, _changes ->
        account = @repo.get!(Account, params[:account_from_id])
        new_balance = (account.current_balance - params[:amount])
        if new_balance >= 0 && params[:amount] > 0 do
          Ecto.Changeset.change(account, current_balance: new_balance)
          |> @repo.update
        else
          {:error, "error"}
        end
      end)
    @repo.transaction(multi)
  end

  def insert_transfer_transaction(params) do
    multi = 
      Multi.new()
      |> Multi.insert(:transaction, Transaction.changeset(%Transaction{}, params))
      |> Multi.run(:account_from, fn _repo, _changes ->
        account = @repo.get!(Account, params[:account_from_id])
        new_balance = (account.current_balance - params[:amount])
        if new_balance >= 0 && params[:amount] > 0 do
          Ecto.Changeset.change(account, current_balance: new_balance)
          |> @repo.update
        else
          {:error, "error"}
        end
      end)
      |> Multi.run(:account_to, fn _repo, _changes ->
        account = @repo.get!(Account, params[:account_to_id])
        current_balance = account.current_balance
        account = Ecto.Changeset.change account, current_balance: current_balance + params[:amount]
        case @repo.update account do
          nil -> {:error, :not_found}
          account_to -> {:ok, account_to}
        end
      end)
    @repo.transaction(multi)
  end
end
