defmodule Banking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :account_from_id, references(:accounts)
      add :amount, :integer
      add :kind, :string
      add :account_to_id, references(:accounts)
      timestamps()
    end
  end
end
