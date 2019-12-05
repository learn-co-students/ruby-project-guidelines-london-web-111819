class RemovePrepTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :prep_time
  end
end
