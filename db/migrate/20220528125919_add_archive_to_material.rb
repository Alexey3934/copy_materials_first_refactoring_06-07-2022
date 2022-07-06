class AddArchiveToMaterial < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :archive, :boolean
  end
end
