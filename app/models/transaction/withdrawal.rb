class Transaction::Withdrawal < Transaction
  private

  def perform_transaction
    self.balance = account.withdraw(amount)
  end
end
