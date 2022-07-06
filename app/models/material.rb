class Material < ApplicationRecord
  # belongs_to :category, optional: true
  belongs_to :category
  has_many :requests, dependent: :destroy


  attr_accessor :categoty_level1_cklicked
  attr_accessor :categoty_level2_cklicked
  attr_accessor :categoty_level3_cklicked
  attr_accessor :result_category_name


  validates :unit, presence: true
  validates :price_retail, format: { with: /\d*/, message: "только цифры" }
  validates :price_wholesale, format: { with: /\d*/, message: "только цифры" }
  validates :amount_wholesale, format: { with: /\d*/, message: "только цифры" }
  validates :description, presence: true
  validates :phone,       format: { with: /[+]?\d+/, message: "только цифры" }


  scope :to_modareting,->(id){find(id).update(to_moderating:true)}
  scope :active       ,->(id){where(user_id:id, to_moderating:false)}
end


