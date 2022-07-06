class AddActiveToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :active, :boolean
  end
end
