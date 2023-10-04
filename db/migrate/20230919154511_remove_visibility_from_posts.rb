# frozen_string_literal: true

class RemoveVisibilityFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :visibility, :integer
  end
end
