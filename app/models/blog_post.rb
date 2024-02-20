class BlogPost < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :category

  enum status: {
    pending: 0,
    publish: 1,
    archived: 2 
  }

end
