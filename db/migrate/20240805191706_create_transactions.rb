class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :type, null: false
      t.references :account, null: false
      t.decimal :amount, null: false
      t.decimal :balance, precision: 15, scale: 2, null: false
      t.references :origin, polymorphic: true, null: false

      t.timestamps
    end
  end
end
