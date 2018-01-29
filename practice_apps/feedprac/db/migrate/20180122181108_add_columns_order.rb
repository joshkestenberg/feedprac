class AddColumnsOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :pickup_start, :datetime
    add_column :orders, :pickup_end, :datetime
    add_column :orders, :dropoff_end, :datetime
    add_column :orders, :dropped_off, :datetime
    add_column :orders, :request_pending, :bool
    add_column :orders, :donater_id, :integer
    add_column :orders, :donatee_id, :integer
    add_column :orders, :driver_id, :integer
    add_column :orders, :driver_admin_id, :integer    
  end
end
