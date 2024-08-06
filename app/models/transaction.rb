class Transaction < ApplicationRecord
  belongs_to :origin, polymorphic: true
  belongs_to :account

  before_create :validate_amount, :perform_transaction

  scope :deposits, -> { where(type: "Transaction::Deposit") }
  scope :withdrawals, -> { where(type: "Transaction::Withdrawals") }
  scope :recent_movements, -> { where(created_at: Date.today.beginning_of_month..) }
  scope :monthly_statement, -> (month) { where(created_at: month.beginning_of_month..month.end_of_month) }

  private

  def validate_amount
    raise Exceptions::InvalidAmount if amount <= 0
  end

  def perform_transaction
    raise NotImplementedError
  end
end
