require "test_helper"

class TransactionTest < ActiveSupport::TestCase

  test "combines all transaction types" do
    Transaction::Deposit.create(account: accounts(:empty_account), amount: 200.0, origin: branch_offices(:one))
    Transaction::Withdrawal.create(account: accounts(:rich_account), amount: 20.0, origin: branch_offices(:one))
    transaction_types = Transaction.all.map(&:type)
    ["Transaction::Deposit", "Transaction::Withdrawal"].each do |type|
      assert transaction_types.include?(type)
    end
  end
end
