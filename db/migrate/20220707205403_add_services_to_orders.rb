class AddServicesToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :service, null: false, foreign_key: true
  end
end
