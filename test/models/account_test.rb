require "test_helper"

class AccountTest < ActiveSupport::TestCase
  # describe Account do
  test "Account#aperture creates a new active account" do
    owner = people(:joe)
    branch_office = branch_offices(:one)
    assert_difference "Account.count" do
      Account.aperture(owner: owner, branch_office: branch_office)
    end
  end

  test "Account#deposit updates the balance with the added amount" do
    acct = accounts(:empty_account)
    initial_balance = acct.balance
    amount = 255.0

    acct.deposit(amount)
    assert_equal acct.balance, initial_balance + amount
  end

  test "account#withdraw updates the balance with the substracted amount" do
    acct = accounts(:average_account)
    initial_balance = acct.balance
    amounts = [255.0, 0.01, 1000]

    amounts.each { |amount| acct.withdraw(amount) }
    assert_equal acct.balance, initial_balance - amounts.sum
  end

  test "account#withdraw will raise error if amount is greater than balance" do
    acct = accounts(:average_account)
    initial_balance = acct.balance
    amount = initial_balance + 0.01

    assert_raise Exceptions::InvalidAmount do
      acct.withdraw(amount)
    end
    assert_equal acct.balance, initial_balance
  end

  test "account responds to owner_name" do
    owner = people(:joe)
    branch_office = branch_offices(:one)

    acct = Account.build(balance: 0.00, owner: owner, branch_office: branch_office)
    assert_respond_to acct, :owner_name, owner.name
  end

  test "account#account_type returns the owner type " do
    branch_office = branch_offices(:one)

    [people(:joe), businesses(:one)].each do |owner|
      a = Account.build(balance: 0.00, owner: owner, branch_office: branch_office)
      assert_equal a.account_type, owner.class.name
    end
  end
end
