# frozen_string_literal: true

# friendship model
class Friendship < ApplicationRecord
  self.table_name = 'friendships'
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
end
