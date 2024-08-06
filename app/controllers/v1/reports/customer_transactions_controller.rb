class V1::Reports::CustomerTransactionsController < ApplicationController
  def show
    render json: { customer_transactions: query }, status: :ok
  end

  private

  def query
    date = report_date
    trns = Account.select("accounts.owner_id, accounts.owner_type, COUNT(transactions.id) AS transactions_count")
                  .joins(:transactions)
                  .where(transactions: { created_at: (date.beginning_of_month..date.end_of_month) })
                  .group("accounts.owner_id, accounts.owner_type")
                  .order("transactions_count DESC")

    trns.map do |count|
      {
        name: count.owner_name,
        transaction_count: count.transactions_count
      }
    end
  end

  def report_date
    year = params[:year] ? params[:year] : Date.today.year
    month = params[:month] ? params[:month] : Date.today.month - 1

    Date.parse("#{year}-#{month}-01")
  end
end
