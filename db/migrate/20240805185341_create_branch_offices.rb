class CreateBranchOffices < ActiveRecord::Migration[7.1]
  def change
    create_table :branch_offices do |t|
      t.string :street_address
      t.string :city

      t.timestamps
    end
  end
end
