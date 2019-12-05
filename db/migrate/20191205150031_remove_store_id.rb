class RemoveStoreId < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :store_id
  end
end
