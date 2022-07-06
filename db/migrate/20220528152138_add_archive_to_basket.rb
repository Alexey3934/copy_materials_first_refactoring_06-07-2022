class AddArchiveToBasket < ActiveRecord::Migration[7.0]
  def change
    add_column :baskets, :archive, :boolean
  end
end
