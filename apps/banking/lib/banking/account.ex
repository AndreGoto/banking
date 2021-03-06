defmodule Banking.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :current_balance, :integer, default: 100_000
    has_many :transactions, Banking.Transaction
    timestamps()
  end

  def changeset(account, params \\ %{}) do
    account
    |> cast(params, [:email])
    |> validate_required([:email, :hashed_password])
  end

  def changeset_with_password(account, params \\ %{}) do
    account
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, required: true)
    |> hash_password
    |> changeset(params)
  end

  def current_balance_changeset(changeset) do
    validate_number(changeset, :current_balance, greater_than_or_equal_to: 0)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, Banking.Password.hash(password))
  end
  defp hash_password(changeset), do: changeset
end
