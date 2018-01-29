class AddColumnsUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_column :users, :driver_admin_id, :integer
  end
end
