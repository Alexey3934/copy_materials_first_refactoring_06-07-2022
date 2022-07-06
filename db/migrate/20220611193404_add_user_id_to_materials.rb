class AddUserIdToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_reference :materials, :user, foreign_key: true
    # , null: false
  end
end
