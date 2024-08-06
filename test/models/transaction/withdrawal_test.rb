require "test_helper"

class Transaction::WithdrawalTest < ActiveSupport::TestCase

  test "Do not combines all transaction types" do
    Transaction::Deposit.create(account: accounts(:empty_account), amount: 200.0, origin: branch_offices(:one))
    Transaction::Withdrawal.create(account: accounts(:rich_account), amount: 20.0, origin: branch_offices(:one))
    transaction_types = Transaction::Withdrawal.all.map(&:type)
    assert_not transaction_types.include?("Transaction::Deposit")
    assert transaction_types.include?("Transaction::Withdrawal")
  end

  test "transaction changes balance" do
    acct = accounts(:average_account)
    assert_difference "acct.balance", -200 do
      Transaction::Withdrawal.create(account: acct, amount: 200.0, origin: branch_offices(:one))
    end
  end
end
