class V1::Accounts::InquiriesController < ApplicationController
  before_action :load_account

  def account_statement
    statement = @account.transactions.monthly_statement(statement_date)
    render json: {
        account_number: @account.account_number,
        lastBalance: statement.last.balance,
        movements: statement
      }, status: :ok
  end

  def current_balance
    render json: {
        account_number: @account.account_number,
        balance: @account.balance
      }, status: :ok
  end

  def recent_movements
    render json: {
        account_number: @account.account_number,
        balance: @account.balance,
        movements: @account.transactions.recent_movements
      }, status: :ok
  end

  private

  def load_account
    @account = Account.find_by(id: params[:account_id])
  end

  def statement_date
    year = params[:year] ? params[:year] : Date.today.year
    month = params[:month] ? params[:month] : Date.today.month - 1

    Date.parse("#{year}-#{month}-01")
  end
end
