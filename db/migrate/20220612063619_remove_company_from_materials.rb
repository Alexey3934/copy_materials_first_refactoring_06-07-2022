class RemoveCompanyFromMaterials < ActiveRecord::Migration[7.0]
  def change
    remove_column :materials, :company, :string
  end
end
