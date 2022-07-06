class AddPurseToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :purse, :integer
  end
end
