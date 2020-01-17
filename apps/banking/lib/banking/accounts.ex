defmodule Banking.Accounts do

  import Ecto.Query
  alias Banking.{Account}

  @repo Banking.Repo

  def insert_account(params) do
    %Account{}
    |> Account.changeset_with_password(params)
    |> @repo.insert
  end

  def get_by_id(id) do
    case @repo.get_by(Account, id: id) do
      nil ->
        {:error, :not_found}
      account ->
        {:ok, account}
    end
  end
end
