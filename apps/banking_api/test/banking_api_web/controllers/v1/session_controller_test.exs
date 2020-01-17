defmodule BankingApiWeb.V1.SessionControllerTest do
  use BankingApiWeb.ConnCase
  import Routes
  alias Banking.{Accounts}


  describe "create/2" do
    test "returns a token", %{conn: conn} do
      {:ok, account} = Accounts.insert_account(%{
        password: "12345678",
        password_confirmation: "12345678",
        email: "test@test.com"
      })

      conn = post(conn, session_path(conn, :create),
        %{"id" => account.id, "password" => account.password})

      assert json_response(conn, 201)
    end
  end
end
