class CreateOrdersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :time_left
      t.integer :cost
      t.integer :customer_id
      t.integer :shop_id
      t.integer :product_id
    end
  end
end
