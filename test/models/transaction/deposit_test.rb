require "test_helper"

class Transaction::DepositTest < ActiveSupport::TestCase

  test "Do not combines all transaction types" do
    Transaction::Deposit.create(account: accounts(:empty_account), amount: 200.0, origin: branch_offices(:one))
    Transaction::Withdrawal.create(account: accounts(:rich_account), amount: 20.0, origin: branch_offices(:one))
    transaction_types = Transaction::Deposit.all.map(&:type)
    assert transaction_types.include?("Transaction::Deposit")
    assert_not transaction_types.include?("Transaction::Withdrawal")
  end

  test "transaction changes balance" do
    acct = accounts(:average_account)
    assert_difference "acct.balance", 2000 do
      Transaction::Deposit.create(account: acct, amount: 2000.0, origin: branch_offices(:one))
    end
  end
end
