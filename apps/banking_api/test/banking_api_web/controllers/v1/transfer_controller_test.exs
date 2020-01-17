defmodule BankingApiWeb.V1.TransferControllerTest do
  use BankingApiWeb.ConnCase
  import Routes
  import BankingApiWeb.Auth.Guardian


  describe "create/2" do
    test "returns 201 for a valid transfer", %{conn: conn} do
      {:ok, account_from} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      {:ok, account_to} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      transaction_fixture = %{"transaction" => 
        %{
          "amount" => 100,
          "account_from_id" => account_from.id,
          "account_to_id" => account_to.id
        }
      }

      {:ok, token, _} = encode_and_sign(account_from, %{}, token_type: :access)

      conn = conn
             |> put_req_header("authorization", "bearer: " <> token)
             |> post(transfer_path(conn, :create), transaction_fixture)

      assert json_response(conn, 201)
    end

    test "returns 422 for an invalid withdraw", %{conn: conn} do
      {:ok, account_from} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      {:ok, account_to} = Banking.Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })
      transaction_fixture = %{"transaction" => 
        %{
          "amount" => 1_000_000,
          "account_from_id" => account_from.id,
          "account_to_id" => account_to.id
        }
      }

      {:ok, token, _} = encode_and_sign(account_from, %{}, token_type: :access)

      conn = conn
             |> put_req_header("authorization", "bearer: " <> token)
             |> post(transfer_path(conn, :create), transaction_fixture)

      assert json_response(conn, 422)
    end
  end
end
