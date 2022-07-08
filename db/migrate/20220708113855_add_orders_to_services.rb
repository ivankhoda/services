class AddOrdersToServices < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :order, null: true, foreign_key: true
  end
end
