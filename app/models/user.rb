# frozen_string_literal: true

# user model
class User < ApplicationRecord
  validates_presence_of :email
  has_one :profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'User', dependent: :destroy, through: :friendships, source: :friend
  has_many :sent_messages, class_name: 'Message', dependent: :destroy, foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', dependent: :destroy, foreign_key: 'receiver_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == 'admin'
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id remember_created_at reset_password_sent_at
       reset_password_token role updated_at]
  end
end
