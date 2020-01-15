defmodule BankingApiWeb.V1.AccountController do
  use BankingApiWeb, :controller

  def create(conn, %{"account" => account_params}) do
    case Banking.Accounts.insert_account(account_params) do
      {:ok, account} -> 
        conn
        |> put_status(:created)
        |> json(account.email)
      {:error, changeset} -> 
        conn
        |> put_status(422)
        |> json("invalid")
    end
  end
end
