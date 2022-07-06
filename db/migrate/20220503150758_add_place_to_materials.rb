class AddPlaceToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :place, :string
  end
end
