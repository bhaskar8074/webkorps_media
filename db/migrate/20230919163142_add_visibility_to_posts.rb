# frozen_string_literal: true

class AddVisibilityToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :visibility, :string
  end
end
