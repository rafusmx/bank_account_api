class V1::Accounts::TransactionsController < ApplicationController
  before_action :load_account

  def deposit
    transaction = Transaction::Deposit.create(transaction_params)
    render_transaction_result(transaction)
  end

  def withdraw
    transaction = Transaction::Withdrawal.create(transaction_params)
    render_transaction_result(transaction)
  end

  private

  def load_account
    @account = Account.find_by(id: params[:account_id])
  end

  def transaction_params
    params.permit(:account_id, :amount, :origin_type, :origin_id)
  end

  def render_transaction_result(transaction)
    if transaction.errors.any?
      render json: { errors: transaction.errors.full_messages }, status: :bad_request
    else
      @account.reload
      render json: {
          account_number: @account.account_number,
          balance: @account.balance
        }, status: :ok
    end
  end
end
