class ChangeServicesColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :services, :category, :category_title
  end
end
