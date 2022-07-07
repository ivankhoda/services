class ChangeOrderColumnsNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :client, :client_name
    rename_column :orders, :assignee, :assignee_name
  end
end
