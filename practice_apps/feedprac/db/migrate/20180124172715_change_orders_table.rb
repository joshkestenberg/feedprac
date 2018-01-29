class ChangeOrdersTable < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :request_pending, :boolean
  end
end
