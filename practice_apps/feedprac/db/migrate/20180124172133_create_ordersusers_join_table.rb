class CreateOrdersusersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :orders, :users, id: false
  end
end
