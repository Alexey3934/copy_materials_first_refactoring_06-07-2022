class AddForUserIdToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :for_user_id, :integer
  end
end
