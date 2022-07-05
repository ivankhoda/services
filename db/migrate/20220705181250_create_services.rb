class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.text :title
      t.text :category
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
