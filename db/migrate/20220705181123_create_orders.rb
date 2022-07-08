class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.text :client
      t.text :services, array: true, default: [], using: "(string_to_array(services, ','))"
      t.text :assignee
      t.integer :price
      t.references :client, null: false, foreign_key: true
      t.references :assignee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
