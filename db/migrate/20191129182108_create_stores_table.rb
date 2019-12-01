class CreateStoresTable < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :menu
    end
  end
end
