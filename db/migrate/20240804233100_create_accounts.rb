class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :owner, polymorphic: true, null: false
      t.references :branch_office, null: false
      t.decimal :balance, default: 0.0, null: false
      t.integer :account_number
      t.datetime :activated_on
      t.datetime :closed_on

      t.timestamps
    end
  end
end
