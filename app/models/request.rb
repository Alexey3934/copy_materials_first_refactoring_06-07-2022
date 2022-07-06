class Request < ApplicationRecord
  belongs_to :user
  belongs_to :material

  scope :for_user,-> (user_id){where(for_user_id: user_id, "seller_side":true)}
  
end
