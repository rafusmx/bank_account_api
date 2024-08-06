require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get deposit" do
    acct = accounts(:average_account)
    office = BranchOffice.create(street_address: "321 test st", city: "test-city")

    put deposit_v1_account_transactions_url(acct.id),
      params: { account: { account_id: acct.id, origin_type: office.class.name, origin_id: office.id, amount: 100 }}
    assert_response :success
  end

  test "transactions#deposit should add to the account balance" do
  acct = accounts(:average_account)
  office = BranchOffice.create(street_address: "320 test st", city: "test-city")

    assert_difference "acct.balance", 100 do
      put deposit_v1_account_transactions_url(acct.id),
        params: { account: { account_id: acct.id, origin_type: office.class.name, origin_id: office.id, amount: 100 }}
    end
  end
end
