class ChangeOrdersTable2 < ActiveRecord::Migration[5.0]
  def change
      remove_column :orders, :request_pending
      add_column :orders, :ready_claim, :boolean, default: true
      add_column :orders, :ready_pick, :boolean
      add_column :orders, :transit, :boolean
      add_column :orders, :complete, :boolean
  end
end
