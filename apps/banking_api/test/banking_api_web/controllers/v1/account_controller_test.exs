defmodule BankingApiWeb.V1.AccountControllerTest do
  use BankingApiWeb.ConnCase
  import Routes
  
  @user_fixture %{
    "account" => %{"email" => "cleber@galvao.com", "password" => "clebao123", "password_confirmation" => "clebao123"},
  }

  describe "create/2" do
    test "returns 201 on successfuly created user", %{conn: conn} do
      conn = post(conn, account_path(conn, :create), @user_fixture)
      assert json_response(conn, 201)
    end

    test "returns 422 in case of validation errors", %{conn: conn} do
      account = %{"email" => "invalid_email.com", "password" => "password123"}
      user_fixture = %{@user_fixture | "account" => account}
      conn = post(conn, account_path(conn, :create), user_fixture)

      assert json_response(conn, 422)
    end
  end
end
