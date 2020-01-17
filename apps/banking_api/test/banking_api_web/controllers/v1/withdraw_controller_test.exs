defmodule BankingApiWeb.V1.WithdrawControllerTest do
  use BankingApiWeb.ConnCase
  import Routes
  import BankingApiWeb.Auth.Guardian


  describe "create/2" do
    test "returns 201 for a valid withdraw", %{conn: conn} do
      {:ok, account} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      {:ok, token, _} = encode_and_sign(account, %{}, token_type: :access)

      transaction_fixture = %{"transaction" => %{"amount" => 100, "account_from_id" => account.id }}

      conn = conn
             |> put_req_header("authorization", "bearer: " <> token)
             |> post(withdraw_path(conn, :create), transaction_fixture)

      assert json_response(conn, 201)
    end

    test "returns 422 for an invalid withdraw", %{conn: conn} do
      {:ok, account} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      {:ok, token, _} = encode_and_sign(account, %{}, token_type: :access)

      transaction_fixture = %{"transaction" => %{"amount" => 110_000, "account_from_id" => account.id }}

      conn = conn
             |> put_req_header("authorization", "bearer: " <> token)
             |> post(withdraw_path(conn, :create), transaction_fixture)

      assert json_response(conn, 422)
    end
  end
end
