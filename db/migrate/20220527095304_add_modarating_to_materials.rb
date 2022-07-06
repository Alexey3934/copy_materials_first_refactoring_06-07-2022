class AddModaratingToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :to_moderating, :boolean
  end
end
