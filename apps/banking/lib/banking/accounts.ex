defmodule Banking.Accounts do

  import Ecto.Query
  alias Banking.{Account}

  @repo Banking.Repo

  def insert_account(params) do
    %Account{}
    |> Account.changeset_with_password(params)
    |> @repo.insert
  end
end
