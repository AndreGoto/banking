defmodule Banking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :kind, :string
    belongs_to :account_from, Banking.Account
    belongs_to :account_to, Banking.Account

    timestamps()
  end

  def changeset(transaction, params \\ %{}) do
    transaction
    |> cast(params, [:amount, :kind, :account_from_id])
    |> validate_required([:amount, :kind, :account_from_id])
    |> assoc_constraint(:account_from)
  end
end
