class CreateGenericServices < ActiveRecord::Migration[7.0]
  def change
    create_table :generic_services do |t|
      t.text :title
      t.text :category_title
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
