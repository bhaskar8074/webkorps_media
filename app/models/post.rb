# frozen_string_literal: true

# post model
class Post < ApplicationRecord
  has_many :likes
  enum :visibility, { see_by_public: 0, see_by_friends: 1, only_by_me: 2 }
  belongs_to :user
  has_rich_text :caption

  has_many :likes
  has_many :likers, through: :likes, source: :user
  def self.ransackable_attributes(_auth_object = nil)
    %w[caption visibility]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end
end
