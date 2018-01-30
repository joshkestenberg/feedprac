class ChangeOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :ready_pick
    remove_column :orders, :awaiting_pick
    remove_column :orders, :ready_claim
    remove_column :orders, :awaiting_approval
    remove_column :orders, :complete
    remove_column :orders, :transit
    add_column :orders, :status, :string, default: "available"


  end
end
