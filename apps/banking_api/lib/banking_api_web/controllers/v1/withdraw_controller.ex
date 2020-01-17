defmodule BankingApiWeb.V1.WithdrawController do
  use BankingApiWeb, :controller
  alias Banking.Transactions

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, transaction} <- Transactions.insert_withdraw_transaction(%{
      amount: transaction_params["amount"],
      kind: "withdraw",
      account_from_id: transaction_params["account_from_id"]}
    ) do
      conn
      |> put_status(:created)
      |> json("withdraw")
    else
      {:error, _, _, _} ->
        conn
        |> put_status(422)
        |> json("invalid")
    end
  end
end
