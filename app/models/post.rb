class Post < ApplicationRecord
  enum :visibility, { see_by_public:0 , see_by_friends:1, only_by_me:2 }
  belongs_to :user
end
