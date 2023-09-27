class Profile < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["first_name"]
  end
end
