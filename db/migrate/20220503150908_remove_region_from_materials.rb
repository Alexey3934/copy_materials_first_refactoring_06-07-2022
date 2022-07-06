class RemoveRegionFromMaterials < ActiveRecord::Migration[7.0]
  def change
    remove_column :materials, :region, :string
  end
end
