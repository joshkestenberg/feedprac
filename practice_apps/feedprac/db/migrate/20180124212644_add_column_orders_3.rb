class AddColumnOrders3 < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :claim_time, :datetime
  end
end
