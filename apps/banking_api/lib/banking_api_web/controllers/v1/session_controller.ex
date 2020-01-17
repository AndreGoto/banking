defmodule BankingApiWeb.V1.SessionController do
  use BankingApiWeb, :controller
  alias BankingApiWeb.Auth.Guardian

  def create(conn, %{"id" => id, "password" => password}) do
    with {:ok, account, token} <- Guardian.authenticate(id, password) do
      conn
      |> put_status(:created)
      |> json(token)
    end
  end
end
