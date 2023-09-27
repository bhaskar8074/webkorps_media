class ChangeVisibilityTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :visibility, :integer
  end
end
