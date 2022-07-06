class RemoveArchiveFromMaterials < ActiveRecord::Migration[7.0]
  def change
    remove_column :materials, :archive, :boolean
  end
end
