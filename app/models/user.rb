class User < ApplicationRecord
  has_one :profile , dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: "User", through: :friendships, source: :friend
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    self.role == "admin"
  end
end
