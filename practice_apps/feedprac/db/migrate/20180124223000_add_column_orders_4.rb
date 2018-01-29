class AddColumnOrders4 < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :picked_up, :datetime
  end
end
