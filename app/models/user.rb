class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :pays, dependent: :destroy


  
  # has_many :materials

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :phone, uniqueness: true, format: { with: /[+]?\d+/, message: "формат или +79123334455, или 89213334455" }
         validates :email, uniqueness: false



  scope :sellers,    ->{where("workgroupe":"Покупатель").order(:company)}
  scope :custumers,  ->{where("workgroupe":"Продавец"  ).order(:company)}
  scope :moderators, ->{where("workgroupe":"Модератор" ).order(:company)}
end
