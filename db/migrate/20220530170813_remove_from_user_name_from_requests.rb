class RemoveFromUserNameFromRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :from_user_name, :string
  end
end
