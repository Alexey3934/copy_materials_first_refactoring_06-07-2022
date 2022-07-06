class AddcolumnsToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :custumer_side, :string
    add_column :requests, :seller_side, :boolean
  end
end
