defmodule BankingApiWeb.V1.AccountController do
  use BankingApiWeb, :controller
  alias BankingApiWeb.Auth.Guardian


  def create(conn, %{"account" => account_params}) do
    with {:ok, account} <- Banking.Accounts.insert_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account) do
      conn
      |> put_status(:created)
      |> json(token)
    else
      {:error, changeset} -> 
        conn
        |> put_status(422)
        |> json("invalid")
    end
  end
end
