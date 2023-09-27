class Post < ApplicationRecord
  has_many :likes
  enum :visibility, { see_by_public:0 , see_by_friends:1, only_by_me:2 }
  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes, source: :user
  def self.ransackable_attributes(auth_object = nil)
    ['caption', 'visibility']
  end

  def self.ransackable_associations(auth_object=nil)
    ["user"]
  end
end
