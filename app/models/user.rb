class User < ApplicationRecord
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: "User"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
