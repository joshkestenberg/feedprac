class RemoveColumnsOrders < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.remove :donater_id, :donatee_id, :driver_id, :driver_admin_id
    end
  end
end
