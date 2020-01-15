defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BankingApiWeb do
    pipe_through :api
    resources "/accounts", V1.AccountController, only: [:create]
  end
end
