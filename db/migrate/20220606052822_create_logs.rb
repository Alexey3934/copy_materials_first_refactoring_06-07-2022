class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.string :moderator_name
      t.string :action
      t.string :material_name
      t.string :unit
      t.integer :price_retail
      t.integer :price_wholesale
      t.integer :amount_wholesale
      t.string :date_material

      t.timestamps
    end
  end
end
