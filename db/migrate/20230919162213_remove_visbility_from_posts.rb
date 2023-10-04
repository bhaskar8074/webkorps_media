# frozen_string_literal: true

class RemoveVisbilityFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :visbility, :integer
  end
end
