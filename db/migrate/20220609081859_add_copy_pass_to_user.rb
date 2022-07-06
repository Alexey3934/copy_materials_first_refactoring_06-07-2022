class AddCopyPassToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :copy_pass, :string
  end
end
