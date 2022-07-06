class AddChangeColumnNullToUserEmail < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string, :null => true 
  end

end
