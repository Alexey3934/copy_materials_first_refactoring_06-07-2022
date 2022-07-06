class DropBasketsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :baskets
  end
end
