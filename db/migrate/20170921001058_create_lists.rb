class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.text :description
      t.string :date_pay
      t.integer :cost
      t.integer :target_account
      t.boolean :state

      t.timestamps
    end
  end
end
