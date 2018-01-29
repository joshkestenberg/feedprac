class AddColumnOrders5 < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :awaiting_pick, :boolean
  end
end
