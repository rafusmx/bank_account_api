require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    owner = businesses(:one)
    office = branch_offices(:one)
    post v1_accounts_url,
      params: { account: { owner_id: owner.id, owner_type: owner.class.name, branch_office_id: office.id }}
    assert_response :success
  end

  test "#create should change account list" do
    owner = businesses(:one)
    office = branch_offices(:one)

    assert_difference "Account.count" do
      post v1_accounts_url,
        params: { account: { owner_id: owner.id, owner_type: owner.class.name, branch_office_id: office.id }}
    end
  end

  test "should get destroy" do
    acct = accounts(:empty_account)
    delete v1_account_url(acct.id), params: { account: { id: acct.id } }
    assert_response :success
  end

  test "#destroy should change account list" do
    acct = accounts(:empty_account)

    assert_difference "Account.active.count", -1 do
      delete v1_account_url(acct.id), params: { account: { id: acct.id } }
    end
  end
end
