class Category < ApplicationRecord
    has_many :materials, dependent: :destroy

    validates :name, uniqueness: true, presence: true

    scope :first_level, ->{where(parent_id:nil)}
end
