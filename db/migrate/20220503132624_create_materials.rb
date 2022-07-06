class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials do |t|
      t.references :category, null: false, foreign_key: true
      t.string :description
      t.string :unit
      t.integer :price_retail
      t.integer :price_wholesale
      t.integer :amount_wholesale
      t.string :region
      t.string :company
      t.string :phone

      t.timestamps
    end
  end
end
