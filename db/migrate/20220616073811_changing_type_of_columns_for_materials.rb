class ChangingTypeOfColumnsForMaterials < ActiveRecord::Migration[7.0]
  def change
    change_column :materials, :price_retail, :string
    change_column :materials, :price_wholesale, :string
    change_column :materials, :amount_wholesale, :string
  end
end
