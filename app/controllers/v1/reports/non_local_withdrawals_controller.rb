class V1::Reports::NonLocalWithdrawalsController < ApplicationController
  def show
    render json: { non_local_withdrawals: report_query }, status: :ok
  end

  private

  def report_query
    result_rows = ActiveRecord::Base.connection.execute(raw_query)
    build_report(result_rows)
  end

  def raw_query
    "SELECT a.id, abo.city, SUM(t.amount) AS total_withdrawn
      FROM accounts AS a
      JOIN branch_offices AS abo ON a.branch_office_id = abo.id
      JOIN transactions AS t ON a.id = t.account_id
      JOIN branch_offices tbo ON t.origin_id = tbo.id
      WHERE t.type = 'Transaction::Withdrawal'
            AND tbo.city != abo.city
      GROUP BY a.id, abo.city
      HAVING SUM(t.amount) > 10000;"
  end

  def build_report(result_rows)
    report = []
    result_rows.each do |row|
      report_row = {}
      acct = Account.find_by(id: row["id"])
      report_row["accountID"] = acct.id
      report_row["name"] = acct.owner_name
      report_row["account_type"] = acct.account_type
      report_row["origin_city"] = row["city"]
      report_row["total_withdran"] = row["total_withdrawn"]
      report<< report_row
    end
    report
  end

end
