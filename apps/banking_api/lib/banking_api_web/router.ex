defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BankingApiWeb.Auth.Pipeline
  end

  scope "/api/v1", BankingApiWeb do
    pipe_through :api
    resources "/accounts", V1.AccountController, only: [:create]
    resources "/sessions", V1.SessionController, only: [:create]
  end

  scope "/api/v1", BankingApiWeb do
    pipe_through [:api, :auth]
    resources "/withdraw", V1.WithdrawController, only: [:create]
    resources "/transfer", V1.TransferController, only: [:create]
  end
end
