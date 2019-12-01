class CreateProductsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :prep_time
      t.integer :store_id
      t.integer :customer_id
    end
  end
end
