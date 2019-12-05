class RemoveTimeLeft < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :time_left
  end
end
