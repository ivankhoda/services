class ChangeOrderColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :services, :positions
  end
end
