Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      resources :accounts, only: %i[create destroy] do
        resource :transactions, only: [] do
          put :deposit, controller: "accounts/transactions"
          put :withdraw, controller: "accounts/transactions"
        end
        resource :inquiries, only: [] do
          get :account_statement, controller: "accounts/inquiries"
          get :current_balance, controller: "accounts/inquiries"
          get :recent_movements, controller: "accounts/inquiries"
        end
      end

      namespace :reports do
        resource :customer_transactions, only: :show
        resource :non_local_withdrawals, only: :show
      end
    end
  end
end
