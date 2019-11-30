class CreateCustomersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :username
      t.integer :balance
    end
  end
end
