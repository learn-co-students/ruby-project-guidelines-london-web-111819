class RenameShopIdToStoreId < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :shop_id, :store_id
  end
end
