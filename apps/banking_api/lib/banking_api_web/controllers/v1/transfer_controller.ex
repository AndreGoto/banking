defmodule BankingApiWeb.V1.TransferController do
  use BankingApiWeb, :controller
  alias Banking.Transactions

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, _transaction} <- Transactions.insert_transfer_transaction(%{
      amount: transaction_params["amount"],
      kind: "transfer",
      account_from_id: transaction_params["account_from_id"],
      account_to_id: transaction_params["account_to_id"]
    }) do
      conn
      |> put_status(:created)
      |> json("transfer")
    else
      {:error, _, _, _} ->
        conn
        |> put_status(422)
        |> json("invalid")
    end
  end
end
