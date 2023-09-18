class Post < ApplicationRecord
  enum visbility: {public: "public", friends: "friends", private: "private" }, _prefix: true
  belongs_to :user
end
