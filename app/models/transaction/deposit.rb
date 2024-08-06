class Transaction::Deposit < Transaction

  private

  def perform_transaction
    self.balance = account.deposit(amount)
  end
end
