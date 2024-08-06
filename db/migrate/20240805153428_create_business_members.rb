class CreateBusinessMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :business_members do |t|
      t.references :business, null: false
      t.references :person, null: false

      t.timestamps
    end
  end
end
