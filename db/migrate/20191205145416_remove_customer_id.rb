class RemoveCustomerId < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :customer_id
  end
end
